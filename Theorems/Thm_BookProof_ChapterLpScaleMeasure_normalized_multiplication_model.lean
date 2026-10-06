-- Generated from ChapterLpScaleMeasure.lean — theorem BookProof.ChapterLpScaleMeasure.normalized_multiplication_model
import Mathlib
import Definitions.Def_ChapterLpScaleMeasure
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLpScaleMeasure

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}


noncomputable section

open MeasureTheory ENNReal


open BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterLpScaleMeasure.normalized_multiplication_model [IsFiniteMeasure nu] (hne : nu Set.univ ≠ 0) :
    ∃ U : Lp ℂ 2 ((nu Set.univ)⁻¹ • nu) ≃ₗᵢ[ℂ] Lp ℂ 2 nu,
      ∀ (g : α → ℂ) (hg : MemLp g ⊤ ((nu Set.univ)⁻¹ • nu))
        (u : Lp ℂ 2 ((nu Set.univ)⁻¹ • nu)),
        (U (multOp g hg u) : α → ℂ) =ᵐ[nu] fun x => g x * (U u : α → ℂ) x := by sorry
