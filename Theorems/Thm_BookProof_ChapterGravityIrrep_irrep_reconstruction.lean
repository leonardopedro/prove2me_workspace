-- Generated from ChapterGravityIrrep.lean — theorem BookProof.ChapterGravityIrrep.irrep_reconstruction
import Mathlib
import Definitions.Def_ChapterGravityIrrep
open BookProof.ChapterGravityIrrep



open Matrix
open scoped BigOperators

theorem BookProof.ChapterGravityIrrep.irrep_reconstruction (M : Matrix (Fin 3) (Fin 3) ℝ) :
    (1 / 2 : ℝ) • symTracelessPart M + (1 / 2 : ℝ) • antisymPart M
      + (1 / 3 : ℝ) • (M.trace) • (1 : Matrix (Fin 3) (Fin 3) ℝ) = M := by sorry
