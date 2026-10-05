-- Generated from ChapterFreeFieldBornFiberTwo.lean — theorem BookProof.ChapterFreeFieldBornFiberTwo.two_le_bornFiber_card
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterFreeFieldBornCont
import Definitions.Def_ChapterFreeFieldBornQuotient
import Definitions.Def_ChapterFreeFieldBornFiberCardGeneral
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberTwo
open BookProof.ChapterFreeFieldBornFiberTwo

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral



theorem BookProof.ChapterFreeFieldBornFiberTwo.two_le_bornFiber_card {p : ↥(stdSimplex ℝ (Fin n))} :
    2 ≤ Nat.card ↥(bornMapSphere n ⁻¹' {p}) := by sorry
