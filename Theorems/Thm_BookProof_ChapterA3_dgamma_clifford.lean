-- Generated from ChapterA3.lean — theorem BookProof.ChapterA3.dgamma_clifford
import Mathlib
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.dgamma_clifford (μ ν : Fin 4) :
    dgamma μ * dgamma ν + dgamma ν * dgamma μ =
      (2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by sorry
