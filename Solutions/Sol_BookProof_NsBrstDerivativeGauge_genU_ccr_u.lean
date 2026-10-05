-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.genU_ccr_u
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_genU_apply
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) (p : NSAlg) :
    genU i (X (NSVar.u k) * p) - X (NSVar.u k) * genU i p = if i = k then p else 0 := by

  rw [genU_apply, genU_apply, pderiv_mul, pderiv_X, Pi.single_apply]
  simp only [NSVar.u.injEq]
  by_cases h : i = k
  · subst h; simp
  · rw [if_neg (fun hh : k = i => h hh.symm), if_neg h]; ring
