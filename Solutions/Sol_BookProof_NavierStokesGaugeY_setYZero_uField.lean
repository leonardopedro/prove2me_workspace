-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.setYZero_uField
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

private theorem setYZero_X_y (j : Fin 3) : setYZero (X (NSVar.y j)) = 0 := by simp [setYZero]

private theorem setYZero_X_u (i : Fin 3) :
    setYZero (X (NSVar.u i)) = X (NSVar.u i) := by simp [setYZero]

private theorem setYZero_X_uD (i j : Fin 3) :
    setYZero (X (NSVar.uD i j)) = X (NSVar.uD i j) := by simp [setYZero]

set_option maxHeartbeats 1000000 in

theorem solution (i : Fin 3) : setYZero (uField i) = X (NSVar.u i) := by
  simp [uField, setYZero_X_u, setYZero_X_uD, setYZero_X_y]
