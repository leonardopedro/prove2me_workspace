-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.IsMixing.conjTranspose_mul
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (hV : IsMixing V) : Vᴴ * V = 1 := mul_eq_one_comm.mp hV
