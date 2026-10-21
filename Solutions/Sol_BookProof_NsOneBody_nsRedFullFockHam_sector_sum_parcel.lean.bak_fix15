-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.nsRedFullFockHam_sector_sum_parcel
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_redHam_eq_sum_parcel
import Theorems.Thm_BookProof_NsFullEuler_nsRedFullFockHam_sector
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {D : Submodule ℂ (L2d 6)}
variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (x : nsRedFockCore) (n : ℕ) :
    ((nsRedFullFockHam nu k x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n
      = ∑ p : Fin n, redParcelHam nu k n p
          ⟨((x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n, x.2.2 n⟩ :=
  calc ((nsRedFullFockHam nu k x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n
        = redHam nu k n ⟨((x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n, x.2.2 n⟩ :=
          nsRedFullFockHam_sector nu k x n
      _ = (∑ p : Fin n, redParcelHam nu k n p)
            ⟨((x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n, x.2.2 n⟩ :=
          LinearMap.congr_fun (redHam_eq_sum_parcel nu k n) _
      _ = ∑ p : Fin n, redParcelHam nu k n p
            ⟨((x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n, x.2.2 n⟩ :=
          LinearMap.sum_apply _ _ _
