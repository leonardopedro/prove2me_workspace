-- Generated from ChapterFreeFieldBornFiberBounds.lean — solution of BookProof.ChapterFreeFieldBornFiberBounds.posSupport_card_le_n
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberBounds
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterFreeFieldBornCont
import Definitions.Def_ChapterFreeFieldBornQuotient
import Definitions.Def_ChapterFreeFieldBornFiberCardGeneral
import Definitions.Def_ChapterFreeFieldBornFiberTwo
open BookProof.ChapterFreeFieldBornFiberBounds



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberTwo


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : Fin n → ℝ} : (posSupport p).card ≤ n := by

  simpa [posSupport] using Finset.card_filter_le Finset.univ (fun k => 0 < p k)
