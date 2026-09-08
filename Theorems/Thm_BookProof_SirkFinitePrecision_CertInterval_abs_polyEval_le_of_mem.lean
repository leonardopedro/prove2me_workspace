-- Generated from ChapterSirkFinitePrecision.lean — theorem BookProof.SirkFinitePrecision.CertInterval.abs_polyEval_le_of_mem
import Mathlib
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval






noncomputable section


open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]

theorem BookProof.SirkFinitePrecision.CertInterval.abs_polyEval_le_of_mem (cs : List ℝ) (I : CertInterval) {x : ℝ} (hx : I.Mem x) :
    |polyEval cs x| ≤ max |(evalHorner cs I).lo| |(evalHorner cs I).hi| := by sorry
