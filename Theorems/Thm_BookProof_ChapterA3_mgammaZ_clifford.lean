-- Generated from ChapterA3.lean — theorem BookProof.ChapterA3.mgammaZ_clifford
import Mathlib
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgammaZ_clifford (μ ν : Fin 4) :
    mgammaZ μ * mgammaZ ν + mgammaZ ν * mgammaZ μ =
      (-2 * minkowskiZ μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℤ) := by sorry
