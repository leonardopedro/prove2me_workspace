-- Generated from ChapterPinDoubleCover.lean — solution of BookProof.ChapterPinDoubleCover.LamZ_spec_C
import Mathlib
import Definitions.Def_ChapterPinDoubleCover
import Theorems.Thm_BookProof_ChapterPinDoubleCover_LamZ_spec
open BookProof.ChapterPinDoubleCover



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution :
    ∀ S ∈ Omega, ∀ μ : Fin 4,
      mgamma μ * (Int.castRingHom ℂ).mapMatrix S
        = (Int.castRingHom ℂ).mapMatrix S * (∑ ν : Fin 4, (LamZ S) μ ν • mgamma ν) := by

  intro S hS μ
  have h := LamZ_spec S hS μ
  have h2 := congrArg (Int.castRingHom ℂ).mapMatrix h
  rw [map_mul, map_mul, map_sum] at h2
  simp only [map_zsmul] at h2
  simpa [mgamma] using h2
