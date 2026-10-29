-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.setYZero_nsSymbol2
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY

private theorem setYZero_X_y (j : Fin 3) : setYZero (X (NSVar.y j)) = 0 := by simp [setYZero]

private theorem setYZero_X_u (i : Fin 3) :
    setYZero (X (NSVar.u i)) = X (NSVar.u i) := by simp [setYZero]

private theorem setYZero_X_uD (i j : Fin 3) :
    setYZero (X (NSVar.uD i j)) = X (NSVar.uD i j) := by simp [setYZero]

private theorem setYZero_X_uL (i : Fin 3) :
    setYZero (X (NSVar.uL i)) = X (NSVar.uL i) := by simp [setYZero]

private theorem setYZero_uField2 (i : Fin 3) : setYZero (uField2 i) = X (NSVar.u i) := by
  simp [uField2, setYZero_X_u, setYZero_X_uD, setYZero_X_uL, setYZero_X_y]

private theorem setYZero_uDField (i j : Fin 3) :
    setYZero (uDField i j) = X (NSVar.uD i j) := by
  simp [uDField, setYZero_X_u, setYZero_X_uD, setYZero_X_uL, setYZero_X_y]

set_option maxHeartbeats 1000000 in

theorem solution (nu : ℂ) (i : Fin 3) :
    setYZero (nsSymbol2 nu i) = nsSymbolPoint nu i := by
  simp [nsSymbol2, nsSymbolPoint, setYZero_X_u, setYZero_X_uD, setYZero_X_uL,
    setYZero_uField2, setYZero_uDField]
