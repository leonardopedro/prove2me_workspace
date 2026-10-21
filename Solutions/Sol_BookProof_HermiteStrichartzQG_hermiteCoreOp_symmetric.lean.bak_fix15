-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.hermiteCoreOp_symmetric
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteDiagOp_symmetric
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) :
    SymmetricOn hermiteCore (hermiteCoreOp lam) := by

  intro x y
  exact hermiteDiagOp_symmetric lam
    (Submodule.inclusion (hermiteCore_le_hermiteDiagDomain lam) x)
    (Submodule.inclusion (hermiteCore_le_hermiteDiagDomain lam) y)
