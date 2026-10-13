-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY_genY2_bracket_X_u
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY


private theorem genY_apply (j : Fin 3) (p : NSAlg) :
    genY j p = pderiv (NSVar.y j) p - ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p := by
  simp [genY]

set_option maxHeartbeats 1000000 in

theorem solution (i j : Fin 3) :
    ⁅genY j, genY2 j⁆ (X (NSVar.u i)) = -X (NSVar.uL i) := by
  rw [Ring.lie_def]
  simp [genY_apply, pderiv_X, Pi.single_apply, apply_ite, eq_comm]
