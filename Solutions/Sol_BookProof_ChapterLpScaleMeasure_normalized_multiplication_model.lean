-- Generated from ChapterLpScaleMeasure.lean — solution of BookProof.ChapterLpScaleMeasure.normalized_multiplication_model
import Mathlib
import Definitions.Def_ChapterLpScaleMeasure
import Theorems.Thm_BookProof_ChapterLpScaleMeasure_scaleUnitary_intertwines
open BookProof.ChapterLpScaleMeasure



noncomputable section

open MeasureTheory ENNReal


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}

set_option maxHeartbeats 1000000 in
theorem solution [IsFiniteMeasure nu] (hne : nu Set.univ ≠ 0) :
    ∃ U : Lp ℂ 2 ((nu Set.univ)⁻¹ • nu) ≃ₗᵢ[ℂ] Lp ℂ 2 nu,
      ∀ (g : α → ℂ) (hg : MemLp g ⊤ ((nu Set.univ)⁻¹ • nu))
        (u : Lp ℂ 2 ((nu Set.univ)⁻¹ • nu)),
        (U (multOp g hg u) : α → ℂ) =ᵐ[nu] fun x => g x * (U u : α → ℂ) x := by

  have hc0 : (nu Set.univ)⁻¹ ≠ 0 := ENNReal.inv_ne_zero.2 (measure_ne_top nu _)
  have hctop : (nu Set.univ)⁻¹ ≠ ⊤ := ENNReal.inv_ne_top.2 hne
  exact ⟨scaleUnitary hc0 hctop, fun g hg u => scaleUnitary_intertwines hc0 hctop hg u⟩
