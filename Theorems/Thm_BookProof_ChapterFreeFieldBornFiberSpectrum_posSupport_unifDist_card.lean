-- Generated from ChapterFreeFieldBornFiberSpectrum.lean — theorem BookProof.ChapterFreeFieldBornFiberSpectrum.posSupport_unifDist_card
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterFreeFieldBornCont
import Definitions.Def_ChapterFreeFieldBornQuotient
import Definitions.Def_ChapterFreeFieldBornFiberCardGeneral
import Definitions.Def_ChapterFreeFieldBornFiberTwo
import Definitions.Def_ChapterFreeFieldBornFiberBounds
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberSpectrum
open BookProof.ChapterFreeFieldBornFiberSpectrum

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberTwo
open BookProof.ChapterFreeFieldBornFiberBounds



theorem BookProof.ChapterFreeFieldBornFiberSpectrum.posSupport_unifDist_card {k : ℕ} (hk : 1 ≤ k) (hkn : k ≤ n) :
    (posSupport (unifDist n k)).card = k := by sorry
