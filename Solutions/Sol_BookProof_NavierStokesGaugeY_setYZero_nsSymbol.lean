-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.setYZero_nsSymbol
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Theorems.Thm_BookProof_NavierStokesGaugeY_setYZero_uField
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

private theorem setYZero_X_y (j : Fin 3) : setYZero (X (NSVar.y j)) = 0 := by simp [setYZero]

private theorem setYZero_X_u (i : Fin 3) :
    setYZero (X (NSVar.u i)) = X (NSVar.u i) := by simp [setYZero]

private theorem setYZero_X_uD (i j : Fin 3) :
    setYZero (X (NSVar.uD i j)) = X (NSVar.uD i j) := by simp [setYZero]

private theorem setYZero_X_uL (i : Fin 3) :
    setYZero (X (NSVar.uL i)) = X (NSVar.uL i) := by simp [setYZero]

set_option maxHeartbeats 1000000 in

theorem solution (nu : ℂ) (i : Fin 3) :
    setYZero (nsSymbol nu i) = nsSymbolPoint nu i := by
  simp [nsSymbol, nsSymbolPoint, setYZero_uField, setYZero_X_uD, setYZero_X_uL]

/-! ## The operator form: `y = 0` as an eigenvalue condition on the initial state -/
