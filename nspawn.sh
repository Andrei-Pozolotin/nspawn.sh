#!/bin/bash
# Apache License 2.0
# Copyright 2016 Random Archer
# This file is part of https://github.com/random-archer/nspawn.sh
#!

#
# install/launcher
#
set -o nounset # fail on unset variables
set -o errexit  # fail on any non-zero return
set -o pipefail # fail on any internal pipe error
set -o errtrace # apply ERR trap throughout call stack
set -o functrace # apply DEBUG and RETURN trap throughout the stack 

# discover install folder
ns_inst_dir() {
    local temp_dir="/tmp" # default temporary folder
    local user_dir="/run/user/$UID" # user runtime folder
    if [[ -d $user_dir ]] ; then echo "$user_dir"
    elif [[ -d $temp_dir ]] ; then echo  "$temp_dir"
    else 1>&2 echo "unknown system" ; return 1 ; fi
}

# report install errors
ns_inst_trap_error() {
    local nest=${BASH_SUBSHELL}
    local func=${FUNCNAME[1]}
    local line=${BASH_LINENO[1]}
    local file=${BASH_SOURCE[0]}
    1>&2 echo "#ERR nest='$nest' func='$func' line='$line' file='$file'"
}

# provision program resources
ns_inst_path() {
    local inst_dir=; inst_dir=$(ns_inst_dir)
    local exec_dir="$inst_dir/$ns_build_name/$ns_build_stamp" # program folder
    local exec_pack="$exec_dir.tar.gz" # extracted archive
    if [[ ! -d $exec_dir ]] ; then # install only once
        1>&2 mkdir -p "$exec_dir" # ensure install folder
        sed '0,/^ARCHIVE$/d' "$BASH_SOURCE" > "$exec_pack" # extract archive
        1>&2 tar -x -C "$exec_dir" -f "$exec_pack" # extract program
        1>&2 chmod -R go-rwx "$exec_dir"/ # limit access
        1>&2 rm -f "$exec_pack" # cleanup archive
    fi
    local exec_path="$exec_dir/exec.sh" # program entry point
    echo "$exec_path"
}

# report install errors
trap ns_inst_trap_error ERR

# define globals
declare -r ns_build_name="nspawn.sh"
declare -r ns_build_stamp="2019-03-22_22-22-20"

# invoke executor
ns_inst_exec=$(ns_inst_path)
declare -r ns_inst_exec
source "$ns_inst_exec"

# terminate program
exit $?

# archive separator
ARCHIVE
�      �=�V�H���STg2�Ƙ�mg|�p�	0|dz�a}�T�5ȒZ%C��=����$s�*�dI@�!�{u7���W}ݺu�Vu���џux�^����֫u�momЯ~�������}�)��ث��ٳ�H�1����p7a|�#���O����iC���l�ͪ��lonB����Z�[��OZ�W��g���n����_~޼��-FK�l;��g�����Fcw�h{�Q�p��c;p�1ێ2��ӑ'���9��Ȏ�(I"�i6�^2�\6�p܌	�n^3�}@�[�8
O����,������L�|}�}�rxv��k6ϟ�wl?��;���bo��9[��p�3vq����dl���2~m��r���1g�a�V���si�9@"�CΠ\�ѐ`��p! �!�L�7Py�P$
F<X
D���	ɋU��-1x��A�+��S����'�߇�|Uf<q��oX�տ  K�#;˓��A��2'ސ%ޘ��D2rF�ĳ�fX�!xl'\���k��<Hb��L|Ȁ"|.!����ܵz��������-޵V������޹$���y@Q)4(��V�Tդ�H_�$3̑2w	�2�>�������΃jK�	�Ք�IZ��>1�C�&/�0�=רi]alƪ�E��*݉94MV�ԟ��s1c�.�r1����h����	'��3���r�VSM�ơ�U���S킩�Y ��}/@}a���O�h5��aQ�ż���Y��f§�o�Ы=I�U=��.�ƒTO�uw�zA���5kw�ʗC�������ȓ<������*������a�O�)�*�X*�5��@�z�櫇|)��z\��fE�^��~4�=І70:�,כ
5ȅ�,�$ �I�fj����cru)��H�f��LmA�HyT!�PZ�i�0��"�eeJJ�̍��{BxP7D��-V��26"�GHF'9N�nVB��,�c�"Em��/��\��i/s
{S�]A�Uf���j�&�.1������7?��H��������k����ϓ����q,����82�����ǒ0ĩ�:�'	w!���$�&�d4���� ����]I�$��lѧ�TS.+�`�:sl{�L4�K4���j9����򕸞��V���.�������K�N�E ��cU�d�l�B�	%���_���=�$c�8����R&��BK.�� �	L��A��%��u���F7�/(jYK,|��vb突:p��$5d{�+�Fۼ)X��X����$ͬ��1���n�P� �4�9>mm�ǲ\�气!�O�CBq<(6(����g�l�jT�L>�/A ��vTِp��ŭ�v<�D}�Q�4Eĝ�^6ǶH@�P 5��}bេ�_8�� ��j!���e�Y�iO@�6�0-[�hj�ҟTQE��Ԑ��q��@�#G�K�cPZ���q��AT���ˌ$ޯ�*��tȵ�D"��>���Kb&_1�\�/�y(& ����O�"�Vߢկ��,%�j��n���6��\Q�[�#������/�.
���L�o�D}Pn̝�h�
���  m��)`��9���.fM�bf�$M�\PQ~h�FI
���Rr���a��m'��@�@YA�U�=�+t��KT���4r|�8:�X���ѺX�����⥆h9/�4y�G�3�J�M�Ӡ@�ft�����B=�t��у:�J�4������3����*�F�jei��L=0W�E��F���j��g��Z`�+����nm���j�~����d�K�?�\����v� �|��g�{_�ۀ��'� �� TE )0{ �����7�Qrþ�	���t���P
ɦ��-��&FzJ@n4�>$6�M�9#��e�Z�|t���0�37RNd$�.� �p��ER�����DI�}{��w\E(������|�"O�R9>;(��JX�=m��ã�-�H��J���H<o��ɛ�W�G,�����Afb��oh'!5�%*n�Mqa��)}������l�:�f��f�����]4e"v��!d��"I?R7���}�������v���[� ��ZanOS�����cϾ�� *�<�����/�����s��	ApJ3I:�0�i�(�C�� 1�\��k6�W��i ���EB�JZ���V��/)<�Ѹ��[�m�5n�����A�ՐC��h԰�j�����=@�-��H/Y��(X+(���Ӆ��?^��e�$�4�J�I�z�w�i!��A��]�d�T���\g�v�h1U�}�=��d�Ȏ�E����Y����wig��p��A?s'����H�{��|����,����f%$�=�Gt��F1�at��mճ�ԪgߥU�(��l��z����*;���������#��}��4��>��"�}����'��ãImZ�b�}���`1(�bV�*+���*_�b.�<�X��TLj�b1�q]�`�"������@h~9Z���RR�tG��[Oσ�F���u ������jS����V뵌�o�ۛO���<���W |��/T�7�������^)T��F�*U�)�u����T�"�G��ޞ���d��WA�~x	eq� zm`��}�<��շ�<��9����8�V��Gٵ�PM��=vJ�ZS��19`lH��8�P@s�Y�h���A��Ӕ��j�RjP��E	A�ɇ�XFP�,nk'9Z&A������=�OG��Nb[n�BA�D�}IE_s�>(%SU�B��:�k���anh����Xa�k)�e�$a���V��vbceN�l�t46�Pf�c�A\�������Uu+h*��R&H^~�X�b)�@���uc�I6��=/�I-�?W�͚e�3�I�1��Y�J�p�;����{�Y������	V/X��9��N�8Y�/b�CO��Y���	|ʠ���g�\�7�}���%oF;Q�XWoqw���vo�|���߽=�c{�����;�/=�K����8��o���3O�`ȡx��R��¿�q�x�i���?�{����FI�z�۽ſ�}�v�苋HB���䁯!�~��db��&_ .$�0��{�q{����AY�5��G0kws� s��S�n�`��Ө������F��%�}�,u:�K���6�;���م:�Q��Q�$���a�h�� iiA��9͡Y�oeW��J;D���*^ut�0�����]|Ѳc~c��U)�,�.�t�9��#5R�*�*v���X�N�s(����eʎKc���Y%�[�隬���DI^���fR6cߌ"�gM�N�"��+1̘�J�
�XzD ��&_bρ)��S!U�b�U�3�OV���ӀO�%%S*5��+G+7��Y�<�����l�b6�-��sw��������p�Lҍ����HǗ�i ��GO�euj���i��h}��2�-B�Q���Q�$�X0,05C+:�T�
���}ؘB��JO�Àɵ�0P�m{,��%w���P�L%U슀��&�-o�ޗ�FIW�&���e�yt9c�S�
YGVɓ�!(�-Ô�*1evcYZi�;#�\�^�1.� (����\2:s��tt����'.���,%V���$"~���H��s$����9�����k�_t7P���!T�0c�m�#��
k�Y�.1:����~w��u����Zc{��kl����n{���ڴ�
"8����#�V97�D�ON�h����b�:���:�}�jS. j��K����`P"Nّf��ם����'����Y�l�~M��(X�	��|u��]Oy�Aգ������{'}\t�g�'��~W�i\V�4��)��<��N%k�q���1�a���#�X�e�T_�y���B�Ǐ��l��d��~>9�x1��ӕ�]Zٗ�P�����s�"f �
xW�>Z�5ut�GΗk�2��I���K"�z,�`2��4pJ����b�"5ց��=G����_c�t�p��ȅ.�����a-�]{.��cK��e�d�vP���T(\���&z�WIV2J3t� 5��H�>9�����d�e��F�.�f����(����R���[����d��� x Z��.�`풢�Ly��ZS����.C��Bs�8}\�c��`U�2��]�� �P�*��ay�*z�~r�SވΑ�;71����K�Q�!Lr�@Cۃ��B���p���i�0��}�<q߱al�6j˗u����;���o	�*D�;�@�1�C�o�H�j��Ds/'8]�Q_\yQjY��о��P ����	�9��o�A���a�s>���Y�>�N�]D��Ư��;,�������'>H��Zo�,B���e�6@1�I�ڗ����Y�f�*<A�LK�O��8I��w�Q%�b��4PL&Po�v���Vb�����+��rl�m�oTvFz=��3�����'�)n�^���%b�~��\���<���"�bo/'o�x�ץ��3)�l�kN�e��P[&i7/�P��ܐ��̜��A�3A4�7��r�GB`e��X �/J�W��+wnK�0��������:�6dE���Y��&�>�F���8=+����0:5,��Оw�$w�1|8�3/�	f�]u�j��c4���H�Z��2[�B
�E#t:�(�?`��T}Vm	3��ԗ��;J��q�T�0���ݡ��3Z�eu�QD�7�2��B�c\҄�*�mA��&��^��/W*.G�8U���O�)�d�[�VYn�`�)�e�]A�.���(2l�M�y��2~�XV�<Pч� �vR*��iM�%�,"��|�!�`5��G]us
V� D	�TPůVeJhr�@��`A�׶H@��p��Ƀ8�����>��'�ع<~	�~ŧ]�k��iN�Cuu��A��>�V���N�5(Jh��:�����nX%<)L�`�w%/��S�*��U�mO�e���\�,p�+{�K�26x20�EN�1 z'�F�92��+�L�h�lrW$e��d��C�����SIv��tt�FS@��r�)Y��y���"���!)��T��Aˊ���'��wjTRFosQ�3WS5�]��jt�ذ���q�|*�kb
��tL&_0R��z�>�9�u�;����5�|�ww�k;����e�����`t�,�!3�lg�2˘�|��
�"�����k
��>~��T� ai?;3��x��:�;} A��Fq�csṲ��������SS�`R}ȉ����R�e<��re@��$���>{��;{9Ftch� �4�×��S*��&������.��ܧ��C�[���ipT��E�a�z�b��}��R:�eW��=�4�k� ��QJm&�D'�-�����uU61̛��c`z�-��uK%�}�����O�pݧx�a̍�������G�J2�[�1wK�X�$p#��o�-�M��F�-�M�W�p4�#?;\z��qp{��o�5��Lm�pm��1~�?Ʈ�wː65��X�m�źD��+�>��;Eϥ���/!F8\ ���Xvq�A5>��6�D��iy�C�chI�J~I�K�K۹�ӂIlJoA�_�BN��'͏�n�]ʱ�oR�B�n_�i��¨�0߃P�⮦�AY�`��fx�Lӱ�Y"M�3K��k"�6n���{9�;��v_d2�	,���+1g�7�y��Ł1��G� �}�# F��Wx���
�B�b�ܕӱ
��O
����/ �BF�<��aTW_�v��!A�xH�*K�Auqxt�wx�����~a[_�� �����h���?��_۸1� #[��0mJۗ!��5Z��ܷ1S�;�s$�����4�������w�����q��k��?l�?���C����������\��P&���[�q�F3�'x4%p���j�ڜ���4���4���76����
G1��N�u�k�x}�J͵ �ܗ��K��a,������*�~�Y,2Ϡ�J�e��9�s��H�������U,;J����o�n�F�|�+:Mz(*����Y9L�I��M�l��f���i�-��|�M�V�_�(��$凜��>3��
�P(�c� \"Nx��B@V�D�DN"SG�eo�6�hY���QW
�,�#�isHb�<����^���W���-b��^����<-�W���j�\ɶ��۴��/k�Aq�rg�mI�mG�8'�ڈ���Ia��e���62�R�ijK�d�+?�M��jzJ�3�[��qN�|��q?o��H�aG�E��
Uͯ
�j��N�иP���c@x�IZo���F�Oh��1�3:��!��s(�
A�'0���A�c*��T�i'��� p�>�������ѷ�J˥|���t�B�+�����#��0J\�8ص��L�c�ϼ� 	mMi������+׎�� �p�]iu���'�|p;9kcs�?�d����k��X�`j���u�a��Y@<D=�K�v�B�`�*-_�����hC��`�\�i�r�Q{	���ki$�I�f�P�y q�j�[�2҅��:3F
��L����/dcL\q��6M/���f?H�А�&� �Pۅ)]�ߠ������Ok�k��W���s�B�����:��߷���oUA�_\Af�z�W��y����k�r��<l��2�9�]׊r�i+������omo�s~��0 �ȫ��,t-��9��*8��Ӯ暠�9�W!ʷ8D��<����v��!�y��sg1oo��y�NPL����!��D1[�5��ӥ=���H\�={ղ&w���!����Qm)�f��x� �z�M˱���rܸLX(*nB�)��.̓��g�ho���޻{����l��7�l�?V����:�jX�S>̶��?W'ml:�Q�V�Jo 3��5D��S|1�bcV���{1�p����>Wݪ���Sr����k���_UE�%h���vO���ӝ�G>
��V	��V�����)�z[�٪��#��u0��=D�1T`>���B��:Mi7~��Z��N�_���"�%��T���u��{@�3�h� uG����=��c?8�>�N��#8�8n�U�
{f�G�"����D(���%TK�Xg0xe�Z�v��nu�ov������_�������������F���g#������_�C��)1�h`�����T����oN��);S�*Sxx�.��_-r:nj%��K�M���ф�|�ԝ���>���N�X�	��T�t��DR�E �q�jb�Vx?�{4��!�8��jHt��"��RA��1k_�B�t�S�0���}��g��o���v����p�c��W;�}.~��NfR���$�kZ{�.u�pBW׿����}N�R58���p���r#�RȘ��@=��B&���#���y6�S⮕�,��Zh�A����j�y�ڭr�j��2S�H��"���`y�ɾ�?�l���-s?����.]w����P _�J`�z�)��?��V�n�]��砓m�ϐǄK��K�7��"���!����U/`�_9�^�ٺ�py�,o����fN� �[.��<iۻ��\����nj�^�WB)#U�-����A�I�Q�žv=o����F*�'�����'���y�� Oo<� �s�1�`�cJ��w>�b���d��P��I1@�B`�t��8C�(�������ᛣ�'#�v��:��I�H�U1�j�3�*#-��5^mif/�����M�L�]���nZC��Kh�kUZ�r�<�˳m'�YŃ܊���m��X�܀��h���r�f#�����YH�:V�B���ő@��A��*�>�!���%d���G�.+f9n�jn����Ol���F7|�SK�G��6��	��A!6�f`	�����IU��_3���8	����B��u|	U��UFɏ� �Si���j�<���j*���˷�Y�d8� *��c�n-��:�.>9�/Q�~]s?�K�(�b"@ ;VR��[n�5{��Fۣ@4��&�S�H�L`�fnض$?n^I���rOnA^��q�����r{2&������vX���W@���/l6Y%j�ň�J�4��1�����jvH���J)9qZI��yV#$������y�[I��N"CHV�x�Ta\����n�S'�
ԣ�.9=<Y�hK@JR���,B5��=���t�xo�Aֈ�=�f
�#�۳s�m�ӣr��✖�l6kRŃ	��٣V�̀E�`ϻP��UY�$��,�)v.���0^
W�<.�}�ز�n��+��B��7�S�
S+Y��),�}9��z��[l�\���}����n����������J֓+�|���l��� �|�l��z�3�l��sQT���]4-Q��,6��)��ž�ځ ����"FҪ@M�4#F���@���#��*e&@Q|��y���A�BָG9��p慣B�ҳ3��K�1ID�w�S���0k����r�g,X�0u���S����l|%��(�v2d� "ʪ�&�r��,�� �2\�h��y����B��V�^������<]ٺ]���^�f6�ŸF�L�
��*��6rj}��\Z{�����n�~w�%�����Q�Z�M 9���5�&�`�~���>�iq}�@�"b��tj傷蚅�e�5k�� =�]�YC�.�ɚ�ӭD�~K�3Y��I�7ǫ��E��Q,����묓V� ��t������zU�$���:Qɳ�xL9Y�خ�J\_��\���X�s���!گ4oB�Ҷ۸��5c�B��Ĭ�l�m�9�^����u�
QQ
w�R9(�Sx��bZ?���1V������'�`����Jn}�����?7���
b�Ы�꺽��X�Ӱ�(P\�����U�k�G���Am2X�冑��H���i	�����P�s�g>zF�}���H���i	~��z9/�v~Pj��w�$�|�H�-U�|`��M���v���l�����>��߃b��x6�_d�]M�x��(} 9��!����`R1APK�^_�'.�-$LT�+B [-HHUH�y��tjb�:� ���@��H����7�|a?�f��줽t�#.xD,:Z�)2]B��n�vp�}y���])!چ{@,�m-D(f_!h�s�-�L�*�jeF-�ـ�:�7��bVB^�|�ÏKw��/���R�S\Ʊ��bpf�o����-��v<����ݐµ��^Q�j�/9(�Q�7esW����f�6��y�yi���[��<��L����p{>�D�72~���
���B6��G���� ���?�O&/0�(h�5��?���<���͡[9\7B@��AM �˭�ڿ����:���O�e1�:�`�wV�-�4nė,�I���?@��$}x�'�xhYwc(v�P�D0�=c��oo�׾���ZbsZ\����F���!�u�:�79�����*�q��+����hO��f� H�֤�ػ/�(`@��G���N3ra�UR(�z�gN%�*�lI��+u$��@1�+ȏ�#��A;���Z���֙k��l+�^�Sh�z��s���Q/m�[1 r�$��r[5P���g���N���9j�����*�i�=H�L=�nӰI9[z
?n&�|�*A���R�����g��d�he���xfF[������xҙ�?��C��gEפ�6f/����PIv��������2�3$6AT9&���3��w@�����T�-Vi�����F�q]���Sطp��R�}.��:�D���*�:VSo{uUwc�ץY����ʵި��u��V�<7&��e혼�\\��	����/*���JGkI�-Z�&g^'���������3�u!�j"h2���z�'m������7�6@,t_�W�,E!x� 
�@�vΟ����n�XR�;�.��OǓT�O�;i��ާ?���q��n$�*t��ư�8�*���YhCޝ�W�B)`q<��p�:���Ȱ(�H�uֻ�|)f��%=i4�V���X�g��2�V�H^:�3L�yY�r�/b��7ՃRϏ���C4x2��Ġ3�荑w��E�۶��tn�N�^�˺=>�����z��&1�-^nm���u0�5y$���
�r1�S>���-"7�Z�ۆ�.��`���ˍ8���,J�m�!{YT!�&2V��k��xY+�	�05��,�^Z�R58�~���A^z��Cn���/w�M��&�#� �W���U,޽�y&������n-|2�R�/
�1li�d��1Oz�x�.�\�H�����?���w��*ϳ�y������J�kb[�ôD�ܽ;�Q����۴�(�XVϓ�����mhV���������룹�K���B��M�aO^�[<��j�%%a�@�li4xRf�iD����� \�žEFh����`0�q\�;��!	���x�B�
>��и͵%�`J{3z���92-�*~2�꜈��1��9�t��!)\,gc�AZ������P2�� ����Ćl8����x
,og\���pM���;="��}l�4̀ɕ9���Gl��6�g��d�]B���(*����XjU���9��c��8�ro@TQ������>��˟��킶���{���ػ����6��n������_�'����Fn�хX��+7��g弘�>���n����0,i����6���y�;.ks*�Ž���p}�d�a$�gJ���ٰ�ߒۋ�����b���|a�D�鵴�#/���2[L�6���UX��� ��a��l�Dǃ��б����*�p����.?�FbΛ��QN4m~�V� �৿=���7�P�f_��3hL��t�tٓ��w�b�T� �f_f�"�.*=������C�(�p�p^���1��B�6�z:B������L�G_9!��Hk�k"���&!�T�=Ks������e���#C����L:F�1�Y��3�&�&&� ������t�?�����g���4w~�g��]I�6�3&���c��ձf�~�M�����,p�"Y��o��y밪j�#�����U�	86(�a�[��SKX�9��Őro��.d$�f�WA��,�zn��jo�?2����9��x�V��8�QM�ܼZ�x�L~z�þ�h�d%��m1CW�98Q�����{#������AV͘O�sD����6�Ε��M'��&�$E%�aq6�:8蓧Гk���,�-�L�Z��M�4gV��������T^ '/x����
 �a��D�I��+g�ϵ�lM�U;�'�����~Y�7�Ic�ލm�񉲼q[�"p a��x�@;3�\ �*o�O4�ք�!�s!X�Z#�:o�n��"Y+�AtH�y�3�.7ҘY#;&���}E� �!���آ|/�Bp`�xQL���4O��5��=^%��I��r	$�@&��f,�$����w5_�L}�#��QΜ͇���%YX� 0m�Ni�j��.f\�P��6����\5H
ܧ���q������mQ��o�yK��WR���8����5�����v���Q|�L��t\&�������<��gO���������F�������g߲���fG��^^���A0`T�C_���"w3�9�5��wFi����� U�7e��bN�͕$E=� �<dd?���_�v�4{1�w���|H�O�fJb%5w)�����R�S>ʈ��tOB��]Q������[�;g;T�������8��b�����DG-�P�~1�s25�~3�8�jn�b���p�����(���'���28�NCR6�$^�|4o8�GTZT�̺��AA���Gm����.����03��� � ����l3L6��c�򛄵�d5��p���D6��|{�m���7\��m����͢�[�>�??ym����N$6����K
��`���Y��������tR`	{����OYD2�#� _`�'fǛ?�4H�C�,Q�Y]z��d��G�(�g6˂G1��(��l��5]�V�����d��S!1f�~+_�RB��=���ΰ{|�5�;G�?+�W�!BV�D�JK�&�o��Y�.D�r�U{D0Q�7)�r*0q��f��Oۍ�e;а�ΥΤ������h�m�|A=s���W9P��p8y�K�G�3�_�%�W����'��i��hd1@�p�D�A�i������'����Y�ԺvF醗@�\A����)�~B�7~����{�?�>=�����;͔TL`�rQ��*��wi���e�us>��/����#f�V'�п.������Ʈ3>�(�h�&��A�t�+�f۫T�*>�zf*��9�A�J�W���)��� �-��9ުn���7��=ItK�{)/C �i�>�J0����*��	U;���o���'��78=���w|i>~��O���̳�G�Át�$�W�._L�[L�'5e�Ϻ�d��<~�n\�Fn~����D�c�5�s�A3�E�Ob�\� ��� *��ꐪ��0Ɨ(Y����y?h؏p�\6m�ׁ�����\Ы����t8<���̜��).�qn���s��C/#�[x�a��J��usn�Q7s�'�l�f]H�f��I�O�� �|�����(:���aj�Rбd]:p�\�n���V����;��<�+OQ��A�O�@R ͤ�ضRg��j(7χ|v�`L;�wG��y���[����a��;w�n��7�l5��ǋ������g��}��/����l��{� �˝�w6��&������� ��b�W!_=y@yWE���N��Wɧ����un�n��s��έ'�5J<�Q")ɖ�d98�l�� D�r��"���!S�
���&ÅJ�����P�7�n�k�\l6��dpf�3����
��6Mz�*��P�qmC��s���lg�S���D@�@���d����\ÞF*.����<8,T--�g|y�:?�,&T�\��A�ڡ�+�N~z���߉���.�0�M�t�;�I_��.l��J�_��v��"0e���H��9��A1�(K�V7���f�q�z!��,�̓��}��j%�}O��6+�s�����LaBR뷂��.Zg� �[
��~R�bv��P�Z���%aM�RR�A�2�T)���e�S���	�d`^�S4�J(�����!�� ����Pc-�P��<P/�Q�R�\*���)�]�Q�uԮ�`u��s�wr���~!>����������_`(�g�`N��g�
�����������^0�e
BE��R ����y��h�S"��]rǋ�&�ha��9�.����&�6 ���HޛhS�Qp5�i8�Jנri{�ouw$��
st/N���195���&	�3.5p}��Ô�>����l<�:f�|�p�$�?�##c ^j����k���f�3Ģ����b��)�S���f����T���#&��,�l��Ͱ�!�+U�k/v���`�Ƌ7���59��st�&�]�M�7Gcb`��"Ɛ�Ш�{��u)u�_! �<$Z꓄7�!z��
�tў�;�z��ԣ�#���>�p@b:�j���̸����{������*�Jѣ�a��z��~cGW�� Uף�8�����=(�	�eA�C���F���Ky,���<�,m��P��W�_R�?r������}��.��'I��v̤�?xx'�#/����>�\����@�����mGk	�3�)�vۆ0�@o��a�`�-H��t�E)f�G�0�_>���1����xisc(Î��Y����5�����lPiH��^�=h�-ma?������f�|j+}A2ʩ.\EyN��;�86g����=x'��%#�bF♜!cƇb1���嵏�v|�1xn��F�W՘���6$}�	$1�;]�9*��S�ٓE	���t��c�o_��ݗ�=���	ཝ�y6w�����Ӳ�~�|��eu�����6��7+,.����
���Ӥ��7s��i���CsB2�I���'�U�43y��!C \~�3����n��u�F� a6��P�-���1��� ��'nųv�G,�2)�p��t�׽�d��/���Di��E'B�٘�Ćr@d*X��M)��*�E��gc��������w[����gE:؎�ۊ�����/�",zc����]��7�u��f|C/�Mx	O�����L�:f�[�.���l�pY��}!͠J�Jug�wSV\^q�fã��C���p�P��-�hV�7B���_�nG���|��NЙ%V���4���k��c
�s�g��-[4��'X�7���2�nb���{G�w��c���]��;������g��'����e���Z��{pn���o�� ���w���to��u#�f����Y0Ks�o
0���IC4��*�g^�Y�G
���L/�a,�:���۔b�L2~��6��xs�^�0}�Y���q>�|G�����������P�+U�*l�"�����y����T��!��1
��0��Ӽr}�B�=e�����j�.̃� �i��^�)�}U�t=Q��D����$d;(F���2�ӆܧ��&�`U@�V�Ko�i+�[�GC$ ����/���"�Q����h��~i���t�����4Q�&�gK���f�ݝtU3�G��Ss�{�f����|�6~i]E^�r�C���QM�F���"��J�C�Id&�JԲqx�E�a�Ci��Ff���)c�q،����
[���^Rx�^8,�ē>N^��^����A���_`��f#�#�ƕn���3����1�4I��j"=�G�����r��>�m`����h�9;�v[!�H�x�Ф�AE���Zvq�$Y/}��\��%{)��~�ҥZ�R�q��WPQ-u�]�2������u5w�ޝ���@�LN�O���zO{����o~:I�l�V���ũٷ��JMV݁y���<k��*��#��ts�Ɨ9[�_��B��l���wt����o�ν���&������(����fA� �h�E�"�8�[�-�Kc}v�/���xi��`���g��Q����",�VE�C���Y��#�����4E��F��ٺ )�U"�B�~u�����4f���%;��Ǡ�������,/J-g�r>�\�"�E�^I��`�YԂ��۰O��C���*y՝p�7�w���2B�c?�z���$\ �h�����%��x�G� 	c���K����3�p��b�\{"d���{�&��{y��t�'Tj�Q[o�q�Ʋ���e����UO�Z�&���0'YF��[�"��H'>�WĽ_��%� ��Q��̑�*G�3��0ڄ�~8X��(�Ÿ�*_�jbL^e�j�f#���ڗ����~�g��5�����tt���p�� ���m��n����|��!Z�VL��hkLѪ����7�KA�i |ߗ63�=χS��'y�rez�S&O�P[`��yݢ���mc��aD�x"R�`��r4��Y�(��YN��R���Ut��1� �vɛ���g��$� ���П{�':	���?<�����#b uM�h����{���`������j~�軓����C��˪���}%�6�=�H�Ꮷ�}p�R��O�ŗ���|��K,Yr?���l8��?���s&�)��[�Y���?K�5��\	v�-�d��(�$�6\��J�V��,�����V�HRr�t�4�N.�lf'LZ�{�N#@K�`�7g���c~��A��H2<Nj*-@�Pƕ�t9��`j�|����s��t'~��r���}�?�^PVF(�$�r�|o9H^JYj�1en�°��C;:�٥$�Ԗ��w���D�Jz�e�GU�V��൷��$��&m9�L��^�Q��<h��f8�����l�"$|5���IP�Գ�Z<f��?Z��W�S��C�kP��E�$}���kR�?$̠*DE<��/1R��DPT�T�³|�+�H��@��@��p�rޏ���Cb�^���7w�و>	K����D譶B�ޠ��k.�4A��VHi��=���^B��`i�|k���"�Qp0����K8\�:�X�����ptp���=��o����ms��ҡ
�6�D����<(�z%Sz��o�=�ᴘ�¤���ozQ��������B�0*�Ι7��ȬAa�Y �r>�|�L��X@���Xġ�vܒ��0 s{pnS�;�Xge�x(i?�Q6�??V;8;����yF�_\��7#L������!�N>���#�KI��P�J(����J�ܾ!]�B(��Ǟs�m�Ϧ��=�H�7¹���x��?��Q��	D���������w_?/=]�G��sC��m��|�K��YŠ}���LDD�9r��� /!V��=he�ȦŔ�Ey�I�����()�����w��>�����m���յ���q����@�vc~��u�1#�aYռ��@��'��ӣN�"��W�p�'��^��	6r��R�Q[6����D���?�!z�ͻ��*3\eQljP���e6]�̻pT��	��OR�d|�X�����*ǉ�/ ���D�	&��hۀA}� �ϲ�y�h� lMms6�Ì���l:�n`�#o����DV"�bw�"�n����Y�~�~T��vZQX���(�K�Ҵ�F���̜�J-T�L �O{)�����>��*ǭu:no?�^$S�ACm���`_�&*�i/Dٯ�h�w�-r�����~��Z���[i@�}��y��������Xe�sx7��:�;����ȳ��K�7����@]"gYr!i��l2�2��u��Ѱ���5in���o���;"q��ʂy�d��<�-+����9h)�l�~�k���r��R��&ƒ6e�ˁ�r|m2��V��$ ?sC�E�W���)�F��f9��.3E;��I���KdB�d��gft�8X~�2�4�%W���֩Kc��i�]�Wm��6��C�~<D�5��q}�1�ñ���v�9�E;�c��'�М��B�N^A ��tS��kÀ0�	��T�
��p, 	q���mD�_����?LE��nRSW�E>����>��]'uL�J%#��$�����l[ȢV���]���Ʌ��ί q����va��a8�VjYu�F�%̉G���$(�9�9XRo0�m[�JC��! @�˷ Kt��ZF^�� �b�r=�z�X��e��	�\İ��a���U��zg��wT��)-¦eo�*|H�^UY\ĳ�4�w����eV���5h�8�ށ�1���~_�*�ӟZ��gWD�h������� \������=���ȳ��I���F�C�I6-�$� i�"��Z#cOQ���%8s��/�������wQ�n0�r�ʬ�]������@�]m�b���KC�b�,`�ֻMV��E6.~C_���RA�붡����xxA�+�A(�n��������m��p��I{�����Xw):��C�!�����{�����ޮ�Z�� �~���<������?������w1��rW�7��%�09�e�tA�7/����e�@*�Hx��ˀ�p�a��φ�g����R��Tg ��G\.B��=c��$A� �"7���0��p�Ux��j�'���i�25�~��m�ng�_���a�nW1 *�(�����.lT��Ѓ�ル4�aV�� �K�V�sS��G���i��+5�xV΋9�-8,V;l�_d��G�H���?��w?��cZV�z@�֪�,�Tð^5跭?t>Ϧ+�j[=����Fl�s���~���"��p��Z�Y	T��5�痃INa�:�K���څ�C̮EDp���H3]�5i�>��.���{�a��B��(��m�����Ŀ�N.x�6�|u��ɏ'���5�l�p1>����8i�?i�������9v�_�Ǫ�ߊ��0��Y��W��2y`-���]��������n-�>��[w����$��(�r����p�yQ�����zo]��%}��}�q}��G��zxt�M<�4�\��y��]H2�����J�������&������8L �Ip�k������ڔ��7��F\Oڮ��d!�+n97��L5b��˛:P=+�eoRr�F��ª��Wd�c�C-d��<�P���F�?R6�4��2(��[����b�뙹��3�t�97mB{k�g�f�M\K��l�Hr�o�� m�������B�w�~�X�g�J���ù�fu�m�ILM�+���$�6vf��N�57`Z�F�V+������4�
!2������2��jT&�&��{Dd2]��,�!
�>6a"/! E��<b�.�G����]f/�����R�B����O��v�����>�wh�����������g#����@Y{i��@{E>^�i�* {:�#�����'�|��y����OO��	�}������E�]\�Z�ӭ�/����J���/�p=i$_�<��Gh�Nv��5��b��OE\�ͼ���(���D��AtE�P�8)~L�Y1}t�7;Uf�!1S�aI�c FM�m} �.N�A%�O�Uja�����r4�c!]�ɫ1|Q`n��B.�?k��7 ��U��W+������+R�m�#��JZ��	���_zq��p_�0�	����b0���eFu%ϱ@��e��%��,F0�;-!w�Q!H�6@��6��2������B6#���i���
�����t$�z~����(A�ǁ�C�ɿb��Y���Ar��1�_׃a� ��@����⽭?�^�:�r���o���,���U��Q���e:[�h�
;�ٸ������=�0���6D�+�r���[zP�ckv��ևX�iO!�9t�XW���r��f���wp����ٿ������y6�_h�_����ʄ'�L4�ң?B�6�_C(��셨:�@��k�	��kt�o��y���n7�"e�����>��f(�yR�8��D6�d�Y�>HlQ�,E�k���fkR�R0�@�H&<�O�6���~ȳ�c�a�o��{��8g2X��D�J�j��\g`��j�H���z	/�p����u�v��`廗AB��y;��J����@��o4m���7,�5PZ��Hi(�@BW�^��~\�Yq�F�j+U�����e�x3�\�_�yj��g��u&�Oe�|��KP����~DF^���������h����K�8�QVC��(�!4N������r�0+�����aP
��\+����q������m/l�K�~�,��ފ�c�Y
(�J;�IX��2ͨY��b���S�+�h�5p�*̋�α=X�]D��>��?h��R�զ�������߂7�˳�D���ts��D�~�D�lU4z(�!�"^<)s^��F���i2�=]���o��*m+�n�Kj����v��	��ـD ����!�OR�7�=��/J��5��a�)l�>'ךm�YY���	���7�cB5V�����75K^�г��&'~�|aC�4,��ޡ��L�H}(DSI���Ȏ,e����yK�%�ɾ�N���	�bm/������a�l^9�b�i���c_��	b�P�W�/ٓWǋ�3��;hqaPŪ
Ծl �d ~�Ƹ]���H��0��P�&��i-g&z�7�aQPne�\Y�"���]OL���a���	9���Su�UMp|S*3��Y��GI>�|Pdg�+����h;	'��4���������J��D�	�Vղ~a�C�Y2�y�!�(�����uʓ	"C���r��V�	�2\�������Y1����1�B���}{�G8B����@��F)9���`�i��XX�t�bD����}��*ڞ��\>�����ēO�т�t���4NN�}J�~_�a��!�%�bXRz_ �P�9c�u�T��8��)�/3z�sk��ۛ �%R�2��0�h䍃ǲ�q  ���˪4�["-��YN�GҖ�*cK�,oXs�o��Ő��D�U��h0�O4T5m؁ (ou *�ccE�ۘe��zv��o?������J�����y6���E�9KQ�����;�99�1G�� �X6}x��^����`泞���p�%ԩX���icP�K�S�d�t�_�4EX���
��jatG���p��"��E�c����"��:���~A/#��g�5sy��K���?K��<c�76�`o��;D�<L�?ش�W�]���ü���H0�];�֜�o8	����1P]ſ�FҤ��
��O��2͍�ƌW˽�:(�г�	���A��J��Er����K� ៖�^���O�Z��ƷZ������~q�ڍ��
A��q�V+l �y�wPj��v*�o��}'sÃ� ���OKԔy�t��:k�7!�c���o]�~���� 7h����O`�?��ㅣoj�]��o(��ƣ����oPd2[�RN��7�k;2�Q���m�a����CF��#o=���_���W-��)���+F	!��x�4jqˡť!7�gS�ҵ	  �7^�|�^�n�w��׽��S�ttt�Ƹ��M����q5�┘v&�� �v�ʑ3�e*Յ��/��:���.̨�k��wt����;����G��&���O�?)�H,D�Lov������'p�U�5'��-%P�sL�@|��H����Ӹ�N-|�(;S���#�g֠Y���j�a^�[{���	�[��Zz��g���vւ[*Ԭ�<�Hj��f<r�ȶ�\uUЛ]������b��>��͡8��g���LP��iU�>��OH('�C�l1��
Z����
fQ�n:w����k[���f-,E����S�.(q��"�[x�lQ'Z;��2�)>�mw:�V�����;�Vx6˳��Ar���= ���uMt�ut����Av��"K^j݅t)x{�D��Ȼ_�j=���p6ϲg�+�?\��?����ߣ;���7�l�?-�Q/H^��  hx��B�}^����Y��-՘���Ke�W{�Q��o$���u/��7u`L(�������^�:�g]�ѕX�t��@l;��x2�IxU�(P���FD�!�,@��Sn�6�h	��S�|Ч�M���JOL/E�K)����%jc��K'�UV�zY�t�vPR PV�J-�p��,ezI���Ƅo��M�w?m�`�u�u"p�.*�������n�&h�V�v<.��g\ܙ�	��&iX<�"i0�+��\bo�(K��O���+�iz��[��,�VRv�$��sNP+�y�����F��^��\BLp�.�"u��ɸ��Ҳ��7{�Im��AYm�&odV���us��b� �`�*�^D���=k�,�����A��q�k�ػ�ْ��8u�}M��Z��:��$�r�
��y	)��`B���k��y������As�Fɟ���,�'bN�n��r6k��|����v3T�����{w+�?G��ߍ<����T�W���;�2� ���I����Z��%z9{��5�,�����{؟Q��  �p����Ք��껺` ��gD���i԰FM6(#T��1.��~wƓw�W��;�Ϧٳbh��� ���>���x�÷�	���F�Ք� �x e�!r�=.3PM७�ubI{���\7s>��	�lcĺl�ϓ�ڶ�q���r��u(�J	�@��T ��rj�����1��R.|�Oh�������\�J�,��ˀ� Ƌ�i���@m��4a�ʴ��g�hw��!~�4��;�y�g��sy����:(t��N��� �U��e��f��S�d�~��ߞ���o��B������O�}���oO��ԕ�v��b<?OZ��$�5Hn���/cHw=�$\cL��6^�b���'#�Vռ�e�R��+Kf3\�
|��ߟ�!֐�|.6*���C�+�7Dvs@�ج�W��gY��
��{E�w)^xm{�aC�1�E�<5GT�$G���b��~���B�������@}���oO�X!�/j{f����N� c�S��Ae��J/u�`;۳"�]xɼ��RoᖭW}m��C����>�_\)lZ���Ԏ [
��X'<�����'p{����U|�γgR��<��L௞�Ԡ"-cP*W��ڠo���p2y�@�5ߚ��K<X<`�̿O� 甖[H��JF�*뉥��@�s�cQ�Jc�9��3�m����\�C�I�~p�j�YW�`em8�;�W�pee�j*�W�����%-�.����au����O���I�{��0Vq��_+]�b�j�ik���֭��UpH���N��W"1vi�s�����V�g<h��fi�j|����\�|�4P�r�'�.�!�'@��� 2*�$�;
,Ԇ]��_uRE�x�zj�����Dc�%����+w��h��Q*"�	�E��N�� �Y���,T+�a>���Q�_���aB����֮��#�G��gg+��y��cC�B�a<Y��܃�-�LǏv��|��EM ��iH��-ɲif�%%_A� ��!����\�:�%�jq��ؼ��i���Pf��zO��VoQ�O�����p�M��V���y���w�!	��<ܵ��@i4v���R9�� ��}~�|��v�I7���xi��^�T�����R�4��XY�ZM��ŧ�/���BB�i5��#�j⿭������v��y����W�?�m��7�l��U�/̈�9�s�GF��=G
�lD({F/#&���/cm.>Z�?��;�52����ILG�c�� N��1�󥻈��
{1�MP�)9�P��B�.���z���I�؝�Q΋מ~�lC7���Ӈ�����PC��14C�W1H�*�]� q�gc�R�"˫d��t�I-��$0hc2����Ѹ�7a�+���#��_��b3��A���+A� �m6H��hp��-��alE��DCe�����hz�\�2nԼa�f5�P��I�C���ҋ-�g���f��~�������{G.�����d�������i�-�Њ��%9}}졹�g�C�����!����#��M��y6��?{Q��eCC�y���:��oz{���?�����&��M=��������?ǵ�x�����~e��m��M<������� ���(�9���@C����b}�՗H�k�*�e$�j�@�$Q�V8B�4P�0r^lf�����^�'���|-�p����ą)V(�����:J�@��}*�1�%q1��=�N�?�{�������:Tx����n����!�Q '��PA��N��K���>!W���~��1s��֥�ռI��yw
X��(����)��c/����v�!�c������������l���x6�?��T�XwM�[�b�2���l1�rXi`���3����v�r�E�]k1�A1Sa �[�q�y�2��ً+��ÝS�b�^�<�q
��[Ʋ(T]i/ē�At�H|?H1'�	q��Ĉ]��Ĩ�� �����CkYD�J���r$�ɹmƦS���,��c���4y6�Ax�E�c@�|��R��F����m�-�GB�	k���
���P+Gc1.~]�fb�Ͷ�x,f�O�ZH�Ќ����l]
ĭ�G�s[c5;>N0f9���}t��K�]8��nN�I�^�,���qsȑ�Z3h<Q��"�[�������^#b�Aח85d2�'e��yX#n��"1�D���ee��h8�c��pc�yb�(�� Ҽ��z�.�_&�E���g���������o��]���0y|��跖�큷7 �UV�F��Q��R�Z8���Q�^���촆��8@�b<���`�o�<3d0��z|���žlW��]�+�m���!g(�^�E�9��*A��k��cV2���~���`a�8_�B�tSr�7PvK� ¼�5�Ɣ�+m��O��FL�]"�L����Ig��2yFq/�����o�'�E>&�#=��v�^�Z�Y�ym> g�����_���0B{m�Ē"XѸ����5�,�ڶ?�a��y�؉t$����4��������kp�H:���K�'��ۉ��(�Z~��̗���p�,���{SM��Sd�$��.�1���l�F��Z�V����g��(��|j5�ߖ��4��Ȟ�sW�y`L�.$�u��� �/Wf������Jc�}h�p�jI�o��-����ϒ��_�9�␛TP	[ol=��4|��UNF�f��V�zxn����9/w�sa6�q>��<��O���֏`�n����d�u�:�?�M�4$ו&� ����.�m��S� �Gc�����gf/���7Z��p e���қ��պ�y�������A-_o�κ��#�>�z<�2��A6S�� ����O���R��������D�-�?t�
z�Т�)�s˿:$�@-/9��?�m@>�+�'7����:zJ4ȝ!G�Hgi�_�׷��Kh��D�%�
�,�0�k[Ex��
X,u�P�r��t�:C>����@#D=�F|���?.���u�2�P����qɀ��9Y��iA�j��w��l\��8L��y�7�A�񯯖��g����	�V��?�������;�{���Í��<�?����e�������;��b�$+a�%�@ }�ʊ�`l�3�pz�iFG������I
Q�x��GA��t����M�`RΟ�1|�1c��C�F��m'��RB���g6ET��m����߆��h�=`�j�l��D�/�W��,6����R[Q?+e!3,�O(r��x<�KZ����A�l�E��atɥ�I�o���d�����	0��ݯ�xV?YʪO�n ���;�y>b�#��:|�g�5	�EifY��C�i[.80��U:�����u��aU�Iz��9&�PQvU� ��"ѸO� '��ik~�y&�S1���7g0`V�fy�O�{�a��@J�!�@'<�0/�Y��q����gQѸ�<����ݜ��f��@ ��=�0��9�/����p�Bs��u�[X�Ǩ�ܰ��_��cp��/�n�,>�y�b$���>ߦ+��.0��b�xufuv����7��\��o�r��v2(΋|�
���C�\�=��#�^
�;R95F�Q��D$�n#{o�ͳy6���<�g������Y	�  