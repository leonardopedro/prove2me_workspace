-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.genU_ccr_x
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_genU_apply
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2
open BookProof.NavierStokesGaugeY

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) (p : NSAlg) :
    genU i (X (NSVar.x k) * p) - X (NSVar.x k) * genU i p = 0 := by

  rw [genU_apply, genU_apply, pderiv_mul, pderiv_X_of_ne (by simp)]; ring
