-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsGradedGhostCar
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsGhost_car
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsGh_mul
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsGh_add
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsGh_one
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsGh_zero
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : GhostCAR nsChi nsBeta := by

  classical
  constructor
  · intro a b
    rw [nsChi, nsChi, ← nsGh_mul, ← nsGh_mul, ← nsGh_add, nsGhost_car.chichi a b, nsGh_zero]
  · intro a b
    rw [nsBeta, nsBeta, ← nsGh_mul, ← nsGh_mul, ← nsGh_add, nsGhost_car.betabeta a b, nsGh_zero]
  · intro a b
    rw [nsBeta, nsChi, ← nsGh_mul, ← nsGh_mul, ← nsGh_add, nsGhost_car.betachi a b]
    by_cases h : a = b
    · simp [h, nsGh_one]
    · simp [h, nsGh_zero]
