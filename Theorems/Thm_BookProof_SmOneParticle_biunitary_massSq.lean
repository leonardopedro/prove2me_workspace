-- Generated from ChapterSmOneParticle.lean — theorem BookProof.SmOneParticle.biunitary_massSq
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

theorem BookProof.SmOneParticle.biunitary_massSq {UL UR D : Matrix (Fin 3) (Fin 3) ℂ}
    (hUL : IsMixing UL) (hV : IsMixing V) :
    (UL * Vᴴ * D * URᴴ)ᴴ * (UL * Vᴴ * D * URᴴ) = UR * (Dᴴ * D) * URᴴ := by sorry
