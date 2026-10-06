-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.dgamma_conjTranspose
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Theorems.Thm_BookProof_ChapterMajoranaFourier_mgamma_conjTranspose
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    (dgamma μ)ᴴ = if μ = 0 then dgamma μ else -dgamma μ := by

  rw [dgamma, Matrix.conjTranspose_smul, mgamma_conjTranspose]
  have hstar : star (-Complex.I) = Complex.I := by simp
  by_cases h : μ = 0
  · simp only [h, if_pos]; rw [hstar]; simp 
  · simp only [h]; rw [hstar]; simp
