-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.exists_core_graph_approx
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_inner_hamCoreS_ccHamS
import Theorems.Thm_BookProof_HermiteGraphApprox_tendsto_htrunc
import Theorems.Thm_BookProof_HermiteGraphApprox_eq_zero_of_orth_dense
import Theorems.Thm_BookProof_HermiteGraphApprox_truncCore_coe
import Theorems.Thm_BookProof_HermiteGraphApprox_cauchySeq_hamCoreS_truncCore
import Theorems.Thm_BookProof_DegSchrodinger_contDiff_polyW
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_DegSchrodinger_hamCoreS_symmetricOn
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : MvPolynomial (Fin d) ℂ) (hq : RealCoeff q)
    (S : Finset (Fin d)) (ψ : ccDomain (Vd d)) {ε : ℝ} (hε : 0 < ε) :
    ∃ v : polyGaussCore (d := d),
      ‖(v : L2d d) - (ψ : L2d d)‖ < ε ∧
        ‖hamCoreS (polyW q) (continuous_polyW q) (expBounded_polyW q) S v
          - ccHamS (polyW q) (contDiff_polyW q) S ψ‖ < ε := by

  obtain ⟨g₀, hg₀⟩ := cauchySeq_tendsto_of_complete (cauchySeq_hamCoreS_truncCore hq S ψ)
  have hid : g₀ = ccHamS (polyW q) (contDiff_polyW q) S ψ := by
    refine sub_eq_zero.1 (eq_zero_of_orth_dense polyGaussCore_dense fun y hy => ?_)
    have hlim1 : Tendsto (fun F => (inner ℂ y (hamCoreS (polyW q) (continuous_polyW q)
        (expBounded_polyW q) S (truncCore (ψ : L2d d) F)) : ℂ)) atTop (𝓝 (inner ℂ y g₀)) :=
      tendsto_const_nhds.inner hg₀
    have hlim2 : Tendsto (fun F => (inner ℂ y (hamCoreS (polyW q) (continuous_polyW q)
        (expBounded_polyW q) S (truncCore (ψ : L2d d) F)) : ℂ)) atTop
        (𝓝 (inner ℂ (hamCoreS (polyW q) (continuous_polyW q) (expBounded_polyW q) S ⟨y, hy⟩)
          (ψ : L2d d))) := by
      have heq : (fun F => (inner ℂ y (hamCoreS (polyW q) (continuous_polyW q)
          (expBounded_polyW q) S (truncCore (ψ : L2d d) F)) : ℂ))
          = fun F => (inner ℂ (hamCoreS (polyW q) (continuous_polyW q) (expBounded_polyW q) S
              ⟨y, hy⟩) (htrunc (ψ : L2d d) F) : ℂ) := by
        funext F
        exact (hamCoreS_symmetricOn _ _ _ S ⟨y, hy⟩ (truncCore (ψ : L2d d) F)).symm
      rw [heq]
      exact tendsto_const_nhds.inner (tendsto_htrunc _)
    have hval := tendsto_nhds_unique hlim1 hlim2
    have hmix := inner_hamCoreS_ccHamS hq S ⟨y, hy⟩ ψ
    rw [inner_sub_right, hval]
    exact sub_eq_zero.2 hmix
  have hev1 := Metric.tendsto_nhds.1 (tendsto_htrunc (ψ : L2d d)) ε hε
  have hev2 := Metric.tendsto_nhds.1 hg₀ ε hε
  rw [hid] at hev2
  obtain ⟨F, h1, h2⟩ := (hev1.and hev2).exists
  refine ⟨truncCore (ψ : L2d d) F, ?_, ?_⟩
  · rw [truncCore_coe, ← dist_eq_norm]
    exact h1
  · rw [← dist_eq_norm]
    exact h2
