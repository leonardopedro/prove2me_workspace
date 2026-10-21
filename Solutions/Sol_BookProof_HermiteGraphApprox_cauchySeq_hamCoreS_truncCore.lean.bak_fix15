-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.cauchySeq_hamCoreS_truncCore
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_hn_ne_top_of_cc
import Theorems.Thm_BookProof_HermiteGraphApprox_exists_hamCoreS_bound
import Theorems.Thm_BookProof_HermiteGraphApprox_hn_htrunc_sub_le
import Theorems.Thm_BookProof_HermiteGraphApprox_ccDomain_ae
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_HermiteLadder_exists_ladderOrd_hamPolyL
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
theorem solution {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q)
    (S : Finset (Fin d)) (ψ : ccDomain (Vd d)) :
    CauchySeq (fun F => hamCoreS (polyW q) (continuous_polyW q) (expBounded_polyW q) S
      (truncCore (ψ : L2d d) F)) := by

  obtain ⟨n, hT⟩ := exists_ladderOrd_hamPolyL S q
  obtain ⟨C, hC, hbound⟩ := exists_hamCoreS_bound hq S hT
  have hfin : ∑' b, wt n b * ‖coef b (ψ : L2d d)‖ₑ ^ 2 ≠ ⊤ :=
    hn_ne_top_of_cc ((((ccEquiv (Vd d)).symm ψ : ccSchwartz (Vd d)) : 𝓢(Vd d, ℂ)).smooth ⊤)
      ((ccEquiv (Vd d)).symm ψ).2 (ccDomain_ae ψ) n
  rw [Metric.cauchySeq_iff]
  intro δ hδ
  have htail := ENNReal.tendsto_tsum_compl_atTop_zero hfin
  have h2 : Tendsto (fun F : Finset (Fin d →₀ ℕ) =>
      C * ∑' b : {b // b ∉ F}, wt n (b : Fin d →₀ ℕ) * ‖coef (b : Fin d →₀ ℕ) (ψ : L2d d)‖ₑ ^ 2)
      atTop (𝓝 0) := by
    simpa using ENNReal.Tendsto.const_mul htail (Or.inr hC)
  have hpos : (0 : ℝ≥0∞) < ENNReal.ofReal (δ ^ 2) := ENNReal.ofReal_pos.2 (by positivity)
  obtain ⟨F₀, hF₀⟩ := Filter.eventually_atTop.1 (h2.eventually (gt_mem_nhds hpos))
  refine ⟨F₀, fun F hF F' hF' => ?_⟩
  rw [dist_eq_norm, ← map_sub]
  have h3 := hbound (truncCore (ψ : L2d d) F - truncCore (ψ : L2d d) F')
  have h4 : hn n ((truncCore (ψ : L2d d) F - truncCore (ψ : L2d d) F' :
        polyGaussCore (d := d)) : L2d d)
      ≤ ∑' b : {b // b ∉ F₀}, wt n (b : Fin d →₀ ℕ)
          * ‖coef (b : Fin d →₀ ℕ) (ψ : L2d d)‖ₑ ^ 2 :=
    hn_htrunc_sub_le (ψ : L2d d) n hF hF'
  have h5 := lt_of_le_of_lt (h3.trans (mul_le_mul_right h4 C)) (hF₀ F₀ le_rfl)
  have h6 := (ENNReal.ofReal_lt_ofReal_iff (by positivity)).1 h5
  exact (pow_lt_pow_iff_left₀ (norm_nonneg _) hδ.le two_ne_zero).1 h6
