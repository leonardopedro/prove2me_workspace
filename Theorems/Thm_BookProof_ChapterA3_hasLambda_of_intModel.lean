-- Generated from ChapterA3d.lean — theorem BookProof.ChapterA3.hasLambda_of_intModel
import Mathlib
import Definitions.Def_ChapterA3d
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3c
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.hasLambda_of_intModel (Sz Λz : Matrix (Fin 4) (Fin 4) ℤ)
    (hSS : Sz * Sz = -1)
    (hconj : ∀ μ, -Sz * mgammaZ μ * Sz = ∑ ν, Λz μ ν • mgammaZ ν) :
    HasLambda ((Int.castRingHom ℝ).mapMatrix Sz)
      ((Int.castRingHom ℝ).mapMatrix Λz) := by sorry
