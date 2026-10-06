-- Generated from ChapterLinftyMultiplication.lean — solution of BookProof.ChapterLinftyMultiplication.memLp_top_conj
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication



noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution {φ : α → ℂ} (hφ : MemLp φ ⊤ μ) :
    MemLp (fun x => (starRingEnd ℂ) (φ x)) ⊤ μ := by

  refine ⟨hφ.aestronglyMeasurable.star, ?_⟩
  have hnorm : eLpNorm (fun x => (starRingEnd ℂ) (φ x)) ⊤ μ = eLpNorm φ ⊤ μ := by
    simp [eLpNorm_exponent_top, eLpNormEssSup]
  rw [hnorm]
  exact hφ.eLpNorm_lt_top
