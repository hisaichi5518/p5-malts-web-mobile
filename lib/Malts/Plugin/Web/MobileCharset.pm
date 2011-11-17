package Malts::Plugin::Web::MobileCharset;
use strict;
use warnings;
use HTTP::MobileAgent::Plugin::Charset;
use Encode::JP::Mobile;

sub init {
    my ($class, $c, $conf) = @_;
    my $ma = $c->request->mobile_agent;

    $c->html_content_type(
        ($ma->is_docomo ? 'application/xhtml+xml;charset=' : 'text/html;charset=').
        ($ma->can_display_utf8 ? 'utf-8' : 'Shift_JIS')
    );

    $c->encoding($ma->encoding);
}

1;
__END__

=encoding utf-8

=head1 NAME

Malts::Plugin::Web::MobileCharset - jp mobile plugin for malts

=head1 SYNOPSIS

    package MyApp::Web;
    use parent qw(Malts Malts::Web);

    sub startup {
        my $c = shift;
        $c->plugin('Web::MobileAgent');
    }

=head1 DESCRIPTION

C<html_content_type>とC<encoding>をガラケー用に更新します。

=head1 METHODS

=head2 C<< $class->init($c, $config) >>

=head1 SEE ALSO

L<HTTP::MobileAgent::Plugin::Charset>i, L<Encode::JP::Mobile>
