Name: ldd-requires
Version: 1.0.0
Release: alt1

Summary: Script for generate requires binary file 
License: GPLv3
Group: System/Base

Url: https://github.com/midyukov-anton/ldd-requires
Source: %name-%version.tar

BuildArch: noarch
Requires: glibc-utils
Requires: gettext

%description
Script for generate requires binary file

%description -l ru
Скрипт определяет каких пакетов не хватает для запуска бинарного файла

%prep
%setup

%install
%make
%make_install install DESTDIR=%buildroot

%clean
%{__rm} -rf %{buildroot}

%files
%{_datadir}/locale/*/LC_MESSAGES/ldd-requires.mo
%{_bindir}/ldd-requires

%changelog
* Sun Jun 28 2015 Anton Midyukov <antoha-mi@ya.ru> 1.0.0-alt1
- Initial publish
