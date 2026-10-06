-- Generated from ChapterPinDoubleCover.lean — theorem BookProof.ChapterPinDoubleCover.LamZ_spec_C
import Mathlib
import Definitions.Def_ChapterPinDoubleCover
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterPinDoubleCover


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterPinDoubleCover.LamZ_spec_C :
    ∀ S ∈ Omega, ∀ μ : Fin 4,
      mgamma μ * (Int.castRingHom ℂ).mapMatrix S
        = (Int.castRingHom ℂ).mapMatrix S * (∑ ν : Fin 4, (LamZ S) μ ν • mgamma ν) := by sorry
