-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.setYZero_nsSymbol2
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in

theorem solution (nu : ℂ) (i : Fin 3) :
    setYZero (nsSymbol2 nu i) = nsSymbolPoint nu i := by
  simp [nsSymbol2, nsSymbolPoint]
