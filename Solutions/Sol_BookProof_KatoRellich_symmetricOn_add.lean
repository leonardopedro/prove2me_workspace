-- Generated from ChapterKatoRellichRelative.lean — solution of BookProof.KatoRellich.symmetricOn_add
import Mathlib
import Definitions.Def_ChapterKatoRellichRelative
open BookProof.KatoRellich




open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {H B : D →ₗ[ℂ] F} (hH : SymmetricOn D H) (hB : SymmetricOn D B) :
    SymmetricOn D (H + B) := by

  intro x y
  simp only [LinearMap.add_apply, inner_add_left, inner_add_right, hH x y, hB x y]
