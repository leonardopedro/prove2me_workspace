-- Generated from ChapterA3.lean — theorem BookProof.ChapterA3.mgamma_clifford
import Mathlib
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgamma_clifford (μ ν : Fin 4) :
    mgamma μ * mgamma ν + mgamma ν * mgamma μ =
      (-2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by sorry
