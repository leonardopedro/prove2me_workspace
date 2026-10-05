-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.oseenDrift_eq
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
open BookProof.NsLinearKoopmanEsa




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : NsSystem d) (ubar u : Fin d → ℝ) (i : Fin d) :
    driftAt S u i
      = linDriftAt (oseenMat S ubar) (oseenConst S ubar) u i
        + ∑ j, ∑ k, S.bcoef i j k * (u j - ubar j) * (u k - ubar k) := by

  classical
  simp only [driftAt, linDriftAt, oseenMat, oseenConst, stokesMat]
  have hs : ∑ j, (if i = j then -(S.nu * S.lam i) else 0) * u j = -(S.nu * S.lam i) * u i := by
    rw [Finset.sum_eq_single i]
    · simp
    · intro j _ hj; simp [Ne.symm hj]
    · simp
  simp only [add_mul, Finset.sum_add_distrib, hs, Finset.sum_mul]
  have h1 : ∀ j k : Fin d, S.bcoef i j k * (u j - ubar j) * (u k - ubar k)
      = S.bcoef i j k * u j * u k - S.bcoef i j k * ubar k * u j
        - S.bcoef i j k * ubar j * u k + S.bcoef i j k * ubar j * ubar k := fun j k => by ring
  simp only [h1, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  have h2 : ∑ j, ∑ k, S.bcoef i j k * ubar j * u k = ∑ j, ∑ k, S.bcoef i k j * ubar k * u j := by
    rw [Finset.sum_comm]
  rw [h2]
  ring
