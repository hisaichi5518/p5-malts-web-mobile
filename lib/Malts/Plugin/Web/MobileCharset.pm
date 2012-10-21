package Malts::Plugin::Web::MobileCharset;
use strict;
use warnings;
use HTTP::MobileAgent::Plugin::Charset;
use Encode::JP::Mobile;
use Malts::Util ();

sub init {
    my ($class, $c) = @_;
    $c->add_method(html_content_type => \&_html_content_type);
    $c->add_method(encoding => \&_encoding);
}

# html_content_typeを呼び出すのは大抵1度なのでキャッシュしない。
sub _html_content_type {
    my ($c) = @_;
    my $ma = $c->mobile_agent;

    my $ct = $ma->is_docomo ?
        'application/xhtml+xml;charset=' : 'text/html;charset=';
    $ct .= $ma->can_display_utf8 ? 'utf-8' : 'Shift_JIS';
    return $ct;
}

sub _encoding {
    my ($c) = @_;
    $c->{'Malts::Web::MobileCharset::encoding'} ||=
        Malts::Util::find_encoding($c->mobile_agent->encoding);
}

1;
__END__

=encoding utf-8

=head1 NAME

Malts::Web::MobileCharset - jp mobile plugin for malts

=head1 SYNOPSIS

    package MyApp::Web;
    use strict;
    use warnings;
    use parent qw(Malts);
    use Log::Minimal;
    __PACKAGE__->load_plugins(qw/Web::MobileAgent Web::MobileCharset/);

    sub dispatch {
        debugf $c->encoding;
        debugf $c->html_content_type;
        ...;
    }

=head1 DESCRIPTION

C<html_content_type>とC<encoding>を日本の携帯電話に対応させます。

=head1 METHODS

=head2 C<< $class->init >>

=head2 C<< $c->html_content_type() -> Str >>

    $c->html_content_type;

=head2 C<< $c->encoding() -> Object >>

    $c->encoding;

=head1 SEE ALSO

L<HTTP::MobileAgent::Plugin::Charset>, L<Encode::JP::Mobile>
