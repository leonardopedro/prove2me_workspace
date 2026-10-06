-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.biunitary_massSq
import Mathlib
import Definitions.Def_ChapterSmOneParticle
import Theorems.Thm_BookProof_SmOneParticle_IsMixing_conjTranspose_mul
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {UL UR D : Matrix (Fin 3) (Fin 3) ℂ}
    (hUL : IsMixing UL) (hV : IsMixing V) :
    (UL * Vᴴ * D * URᴴ)ᴴ * (UL * Vᴴ * D * URᴴ) = UR * (Dᴴ * D) * URᴴ := by

  have hL : ULᴴ * UL = 1 := hUL.conjTranspose_mul
  have hVV : V * Vᴴ = 1 := hV
  simp only [Matrix.conjTranspose_mul, Matrix.conjTranspose_conjTranspose, Matrix.mul_assoc]
  rw [← Matrix.mul_assoc ULᴴ UL, hL, Matrix.one_mul, ← Matrix.mul_assoc V Vᴴ, hVV,
    Matrix.one_mul]
