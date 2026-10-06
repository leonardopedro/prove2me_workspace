-- Generated from ChapterA3e.lean — theorem BookProof.ChapterA3.hasAdLambda_of_intModel
import Mathlib
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3c
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.hasAdLambda_of_intModel (Gz Az : Matrix (Fin 4) (Fin 4) ℤ)
    (hconj : ∀ μ, Gz * mgammaZ μ - mgammaZ μ * Gz = ∑ ν, Az μ ν • mgammaZ ν) :
    HasAdLambda ((Int.castRingHom ℝ).mapMatrix Gz)
      ((Int.castRingHom ℝ).mapMatrix Az) := by sorry
