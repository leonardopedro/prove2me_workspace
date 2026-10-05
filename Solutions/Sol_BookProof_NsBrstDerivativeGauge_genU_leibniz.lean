-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.genU_leibniz
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_genU_apply
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (p q : NSAlg) :
    genU i (p * q) = genU i p * q + p * genU i q := by

  rw [genU_apply, genU_apply, genU_apply, pderiv_mul]
