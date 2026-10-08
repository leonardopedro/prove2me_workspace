-- Generated from ChapterSirkFinitePrecision.lean — theorem BookProof.SirkFinitePrecision.CertInterval.mem_evalHorner
import Mathlib
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval


noncomputable section


open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]


theorem BookProof.SirkFinitePrecision.CertInterval.mem_evalHorner : ∀ (cs : List ℝ) (I : CertInterval) (x : ℝ), I.Mem x →
    (evalHorner cs I).Mem (polyEval cs x)
  | [], I, x, _ => by
      simpa [evalHorner, polyEval] using mem_const (0 : ℝ)
  | c :: cs, I, x, hx => by
      have hrec := by sorry
