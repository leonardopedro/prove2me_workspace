-- Generated from ChapterSirkFinitePrecision.lean — theorem BookProof.SirkFinitePrecision.observable_propagation
import Mathlib
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision






noncomputable section


open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]

theorem BookProof.SirkFinitePrecision.observable_propagation {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    (O : F →L[ℂ] F) (u w : F) :
    |(inner ℂ u (O u)).re - (inner ℂ w (O w)).re| ≤ ‖O‖ * (‖u‖ + ‖w‖) * ‖u - w‖ := by sorry
