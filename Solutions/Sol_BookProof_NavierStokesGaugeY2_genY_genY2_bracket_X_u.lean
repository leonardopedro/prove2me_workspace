-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY_genY2_bracket_X_u
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) :
    ⁅genY j, genY2 j⁆ (X (NSVar.u i)) = -X (NSVar.uL i) := by

  rw [Ring.lie_def]
  simp [genY_apply, pderiv_X, Pi.single_apply, apply_ite, eq_comm]
