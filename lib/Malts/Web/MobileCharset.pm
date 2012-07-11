package Malts::Web::MobileCharset;
use strict;
use warnings;
use Exporter 'import';
use HTTP::MobileAgent::Plugin::Charset;
use Encode::JP::Mobile;
use Malts::Util ();

our @EXPORT = qw(html_content_type encoding);

# html_content_typeを呼び出すのは大抵1度なのでキャッシュしない。
sub html_content_type {
    my ($c) = @_;
    my $ma = $c->mobile_agent; # use Malts::Web::MobileAgent;

    my $ct = $ma->is_docomo ?
        'application/xhtml+xml;charset=' : 'text/html;charset=';
    $ct .= $ma->can_display_utf8 ? 'utf-8' : 'Shift_JIS';
    return $ct;
}

# Encode::encode()も毎回find_encoding()してるので
# 呼び出す度find_encoding()するからと言って絶望的に遅くなるわけではない。
sub encoding { Malts::Util::find_encoding($_[0]->mobile_agent->encoding) }

1;
__END__

=encoding utf-8

=head1 NAME

Malts::Web::MobileCharset - jp mobile plugin for malts

=head1 SYNOPSIS

    package MyApp::Web;
    use strict;
    use warnings;
    use parent qw(Malts Malts::Web);
    use Malts::Web::MobileAgent;
    use Malts::Web::MobileCharset;
    use Log::Minimal;

    sub dispatch {
        debugf $c->encoding;
        debugf $c->html_content_type;
        ...;
    }

=head1 DESCRIPTION

C<html_content_type>とC<encoding>を日本の携帯電話に対応させます。

=head1 METHODS

=head2 C<< $c->html_content_type() -> Str >>

    $c->html_content_type;

=head2 C<< $c->encoding() -> Object >>

    $c->encoding;

=head1 SEE ALSO

L<HTTP::MobileAgent::Plugin::Charset>i, L<Encode::JP::Mobile>
