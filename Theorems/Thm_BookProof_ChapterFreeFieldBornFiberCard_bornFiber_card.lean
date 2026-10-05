-- Generated from ChapterFreeFieldBornFiberCard.lean — theorem BookProof.ChapterFreeFieldBornFiberCard.bornFiber_card
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterFreeFieldBornCont
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Definitions.Def_ChapterFreeFieldBornSignFiber
import Definitions.Def_ChapterFreeFieldBornSectionBij
import Definitions.Def_ChapterFreeFieldBornQuotient
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberCard
open BookProof.ChapterFreeFieldBornFiberCard

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornSignFiber BookProof.ChapterFreeFieldBornSectionBij
open BookProof.ChapterFreeFieldBornQuotient



theorem BookProof.ChapterFreeFieldBornFiberCard.bornFiber_card {p : ↥(stdSimplex ℝ (Fin n))}
    (hp : ∀ k, 0 < (p : Fin n → ℝ) k) :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ^ n := by sorry
