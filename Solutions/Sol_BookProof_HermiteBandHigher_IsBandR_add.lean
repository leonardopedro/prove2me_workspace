-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.IsBandR.add
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandDeg_add
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteBand
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in

theorem solution {r m : ℕ} {T S : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hT : IsBandR r m T) (hS : IsBandR r m S) : IsBandR r m (T + S) := by
  obtain ⟨M₁, C₁, hC₁, h₁⟩ := hT
  obtain ⟨M₂, C₂, hC₂, h₂⟩ := hS
  exact ⟨M₁ + M₂, C₁ + C₂, by linarith, Band.add h₁ h₂⟩
