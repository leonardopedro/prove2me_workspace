-- Generated from ChapterFreeFieldBornFiberBounds.lean — theorem BookProof.ChapterFreeFieldBornFiberBounds.posSupport_card_le_n
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterFreeFieldBornCont
import Definitions.Def_ChapterFreeFieldBornQuotient
import Definitions.Def_ChapterFreeFieldBornFiberCardGeneral
import Definitions.Def_ChapterFreeFieldBornFiberTwo
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberBounds
open BookProof.ChapterFreeFieldBornFiberBounds

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberTwo



theorem BookProof.ChapterFreeFieldBornFiberBounds.posSupport_card_le_n {p : Fin n → ℝ} : (posSupport p).card ≤ n := by sorry
