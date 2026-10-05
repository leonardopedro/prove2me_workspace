-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.kato_cutoff_bound
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Theorems.Thm_BookProof_DegKatoEsa_mollified_identity
import Theorems.Thm_BookProof_DegKatoEsa_contDiff_mol
import Theorems.Thm_BookProof_DegKatoEsa_hasCompactSupport_mol
import Theorems.Thm_BookProof_DegKatoEsa_norm_lt_of_mol_ne_zero
import Theorems.Thm_BookProof_DegKatoEsa_tendsto_cnv_mol
import Theorems.Thm_BookProof_DegKatoEsa_memLp_bdd_mul
import Theorems.Thm_BookProof_DegKatoEsa_inner_toLp
import Theorems.Thm_BookProof_DegKatoEsa_norm_toLp_sq
import Theorems.Thm_BookProof_DegKatoEsa_tendsto_toLp_of_le
import Theorems.Thm_BookProof_ConvolutionCalc_contDiff_cnv
import Theorems.Thm_BookProof_ConvolutionCalc_hasCompactSupport_dcoord
import Theorems.Thm_BookProof_DegEnergy_contDiff_cx
import Theorems.Thm_BookProof_DegEnergy_energy_bound
import Theorems.Thm_BookProof_DegEnergy_hasCompactSupport_cx
import Theorems.Thm_BookProof_DegEnergy_norm_cx
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_dcoord
open BookProof.DegKatoEsa




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (hW1 : ∀ x, 1 ≤ W x) (S : Finset (Fin d)) {z : ℂ} (hz : z.re = 0) {u : L2d d}
    (hu : ∀ v : ccDomain (Vd d), (inner ℂ (ccHamS W hWs S v) u : ℂ)
      = z * inner ℂ ((v : L2d d)) u)
    {χ : Vd d → ℝ} (hχ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ) (hχc : HasCompactSupport χ)
    (hχ1 : ∀ x, |χ x| ≤ 1) {B : ℝ} (hdχ : ∀ j x, ‖dcoord j (cx χ) x‖ ≤ B)
    (hA : MemLp (fun x => cx χ x * (u : Vd d → ℂ) x) 2 (volume : Measure (Vd d))) :
    ‖hA.toLp _‖ ^ 2 ≤ 2 * S.card * B ^ 2 * ‖u‖ ^ 2 := by

  classical
  set uf : Vd d → ℂ := (u : Vd d → ℂ) with huf
  have hu2 : MemLp uf 2 (volume : Measure (Vd d)) := Lp.memLp u
  have hum : StronglyMeasurable uf := Lp.stronglyMeasurable u
  have hUloc : LocallyIntegrable uf (volume : Measure (Vd d)) := hu2.locallyIntegrable one_le_two
  have hWc : Continuous W := hWs.continuous
  have hWcC : Continuous (fun y => ((W y : ℝ) : ℂ)) := Complex.continuous_ofReal.comp hWc
  have hWUloc : LocallyIntegrable (fun y => ((W y : ℝ) : ℂ) * uf y)
      (volume : Measure (Vd d)) := by
    have h1 : LocallyIntegrable (fun y => uf y * ((W y : ℝ) : ℂ)) (volume : Measure (Vd d)) := by
      rw [← locallyIntegrableOn_univ] at hUloc ⊢
      exact hUloc.mul_continuousOn hWcC.continuousOn (IsClosed.isLocallyClosed isClosed_univ)
    have heq : (fun y => ((W y : ℝ) : ℂ) * uf y) = fun y => uf y * ((W y : ℝ) : ℂ) := by
      funext y
      ring
    rw [heq]
    exact h1
  -- the compact sets and the localised potential term
  set K : Set (Vd d) := tsupport χ with hKdef
  have hK : IsCompact K := hχc
  set K₁ : Set (Vd d) := Metric.cthickening 1 K with hK₁def
  have hK₁ : IsCompact K₁ := hK.cthickening
  obtain ⟨M, hM⟩ := hK₁.exists_bound_of_continuousOn hWc.continuousOn
  set M' : ℝ := max M 0 with hM'def
  have hM'0 : 0 ≤ M' := le_max_right _ _
  set fK : Vd d → ℂ := K₁.indicator (fun y => ((W y : ℝ) : ℂ) * uf y) with hfKdef
  have hfKm : StronglyMeasurable fK :=
    (hWcC.stronglyMeasurable.mul hum).indicator hK₁.isClosed.measurableSet
  have hfK2 : MemLp fK 2 (volume : Measure (Vd d)) := by
    refine MemLp.of_le (hu2.const_mul (M' : ℂ)) hfKm.aestronglyMeasurable ?_
    filter_upwards with y
    by_cases hy : y ∈ K₁
    · rw [hfKdef, Set.indicator_of_mem hy, norm_mul, norm_mul, Complex.norm_real,
        Complex.norm_real, Real.norm_of_nonneg hM'0]
      exact mul_le_mul_of_nonneg_right ((hM y hy).trans (le_max_left _ _)) (norm_nonneg _)
    · rw [hfKdef, Set.indicator_of_notMem hy, norm_zero]
      exact norm_nonneg _
  have hχ0 : ∀ x, x ∉ K → χ x = 0 := fun x hx => image_eq_zero_of_notMem_tsupport hx
  have hWloc : ∀ x, x ∈ K → fK x = ((W x : ℝ) : ℂ) * uf x := fun x hx => by
    rw [hfKdef, Set.indicator_of_mem (Metric.self_subset_cthickening K hx)]
  -- the mollified sequences
  set v : ℕ → Vd d → ℂ := fun n => cnv uf (cx (mol d n)) with hvdef
  set G : ℕ → Vd d → ℂ := fun n => cnv (fun y => ((W y : ℝ) : ℂ) * uf y) (cx (mol d n))
    with hGdef
  have hvs : ∀ n, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (v n) := fun n =>
    contDiff_cnv hUloc (contDiff_cx (contDiff_mol n))
      (hasCompactSupport_cx (hasCompactSupport_mol n))
  have hGc : ∀ n, Continuous (G n) := fun n =>
    (contDiff_cnv hWUloc (contDiff_cx (contDiff_mol n))
      (hasCompactSupport_cx (hasCompactSupport_mol n))).continuous
  have hGloc : ∀ n x, x ∈ K → G n x = cnv fK (cx (mol d n)) x := by
    intro n x hx
    simp only [hGdef, cnv_apply]
    refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
    by_cases hy : mol d n (x - y) = 0
    · simp [cx, hy]
    · have hlt := norm_lt_of_mol_ne_zero hy
      have hle1 : 1 / ((n : ℝ) + 1) ≤ 1 := by
        rw [div_le_one (by positivity)]
        linarith [(Nat.cast_nonneg n : (0 : ℝ) ≤ n)]
      have hy1 : y ∈ K₁ := Metric.mem_cthickening_of_dist_le y x 1 K hx (by
        rw [dist_comm, dist_eq_norm]
        exact hlt.le.trans hle1)
      simp only [hfKdef, Set.indicator_of_mem hy1]
  -- the energy inequality for each mollification
  have henergy : ∀ n, (∫ x, cx χ x ^ 2 * (starRingEnd ℂ) (v n x) * G n x).re
      ≤ 2 * ∑ j ∈ S, ∫ x, ‖dcoord j (cx χ) x‖ ^ 2 * ‖v n x‖ ^ 2 := fun n =>
    energy_bound S hz (hvs n) (hGc n)
      (fun x => mollified_identity W hWs S hu (contDiff_mol n) (hasCompactSupport_mol n) x)
      hχ hχc
  -- the `L²` vectors
  have hcxs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cx χ) := contDiff_cx hχ
  have hcxc : Continuous (cx χ) := hcxs.continuous
  have hcxcs : HasCompactSupport (cx χ) := hasCompactSupport_cx hχc
  have hcxb : ∀ x, ‖cx χ x‖ ≤ 1 := fun x => by rw [norm_cx]; exact hχ1 x
  have hdc : ∀ j, Continuous (dcoord j (cx χ)) := fun j => (contDiff_dcoord hcxs j).continuous
  have hA2 : ∀ n, MemLp (fun x => cx χ x * v n x) 2 (volume : Measure (Vd d)) := fun n =>
    (hcxc.mul (hvs n).continuous).memLp_of_hasCompactSupport (hcxcs.mul_right)
  have hB2 : ∀ n, MemLp (fun x => cx χ x * G n x) 2 (volume : Measure (Vd d)) := fun n =>
    (hcxc.mul (hGc n)).memLp_of_hasCompactSupport (hcxcs.mul_right)
  have hE2 : ∀ j n, MemLp (fun x => dcoord j (cx χ) x * v n x) 2 (volume : Measure (Vd d)) :=
    fun j n => ((hdc j).mul (hvs n).continuous).memLp_of_hasCompactSupport
      ((hasCompactSupport_dcoord hcxcs j).mul_right)
  have hBl : MemLp (fun x => cx χ x * fK x) 2 (volume : Measure (Vd d)) :=
    memLp_bdd_mul hcxc hcxb hfK2
  have hEl : ∀ j, MemLp (fun x => dcoord j (cx χ) x * uf x) 2 (volume : Measure (Vd d)) :=
    fun j => memLp_bdd_mul (hdc j) (hdχ j) hu2
  -- convergence of the mollifications
  have hconvU := tendsto_cnv_mol (d := d) hum hu2
  have hconvF := tendsto_cnv_mol (d := d) hfKm hfK2
  have tA : Tendsto (fun n => (hA2 n).toLp _) atTop (𝓝 (hA.toLp _)) := by
    refine tendsto_toLp_of_le hA2 hA hconvU 1 fun n => ?_
    refine eLpNorm_le_mul_eLpNorm_of_ae_le_mul (Filter.Eventually.of_forall fun x => ?_) 2
    simp only [Pi.sub_apply]
    rw [← mul_sub, norm_mul]
    exact mul_le_mul_of_nonneg_right (hcxb x) (norm_nonneg _)
  have tB : Tendsto (fun n => (hB2 n).toLp _) atTop (𝓝 (hBl.toLp _)) := by
    refine tendsto_toLp_of_le hB2 hBl hconvF 1 fun n => ?_
    refine eLpNorm_le_mul_eLpNorm_of_ae_le_mul (Filter.Eventually.of_forall fun x => ?_) 2
    simp only [Pi.sub_apply]
    rw [← mul_sub, norm_mul]
    by_cases hx : x ∈ K
    · rw [hGloc n x hx]
      exact mul_le_mul_of_nonneg_right (hcxb x) (norm_nonneg _)
    · have h0 : cx χ x = 0 := by simp [cx, hχ0 x hx]
      rw [h0, norm_zero, zero_mul]
      positivity
  have tE : ∀ j, Tendsto (fun n => (hE2 j n).toLp _) atTop (𝓝 ((hEl j).toLp _)) := by
    intro j
    refine tendsto_toLp_of_le (hE2 j) (hEl j) hconvU B fun n => ?_
    refine eLpNorm_le_mul_eLpNorm_of_ae_le_mul (Filter.Eventually.of_forall fun x => ?_) 2
    simp only [Pi.sub_apply]
    rw [← mul_sub, norm_mul]
    exact mul_le_mul_of_nonneg_right (hdχ j x) (norm_nonneg _)
  -- the energy inequality in `L²` form
  have hcxconj : ∀ x, (starRingEnd ℂ) (cx χ x) = cx χ x := fun x => by simp [cx]
  have hinnerN : ∀ n, (inner ℂ ((hA2 n).toLp _) ((hB2 n).toLp _) : ℂ)
      = ∫ x, cx χ x ^ 2 * (starRingEnd ℂ) (v n x) * G n x := by
    intro n
    rw [inner_toLp]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [map_mul, hcxconj]
    ring
  have hnormE : ∀ j n, ‖(hE2 j n).toLp _‖ ^ 2
      = ∫ x, ‖dcoord j (cx χ) x‖ ^ 2 * ‖v n x‖ ^ 2 := by
    intro j n
    rw [norm_toLp_sq]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [norm_mul, mul_pow]
  have hineqN : ∀ n, (inner ℂ ((hA2 n).toLp _) ((hB2 n).toLp _) : ℂ).re
      ≤ 2 * ∑ j ∈ S, ‖(hE2 j n).toLp _‖ ^ 2 := by
    intro n
    rw [hinnerN n]
    simp only [hnormE]
    exact henergy n
  -- pass to the limit
  have hlimL : Tendsto (fun n => (inner ℂ ((hA2 n).toLp _) ((hB2 n).toLp _) : ℂ).re) atTop
      (𝓝 (inner ℂ (hA.toLp _) (hBl.toLp _) : ℂ).re) :=
    (Complex.continuous_re.tendsto _).comp (tA.inner tB)
  have hlimR : Tendsto (fun n => 2 * ∑ j ∈ S, ‖(hE2 j n).toLp _‖ ^ 2) atTop
      (𝓝 (2 * ∑ j ∈ S, ‖(hEl j).toLp _‖ ^ 2)) :=
    (tendsto_finset_sum S fun j _ => ((tE j).norm).pow 2).const_mul 2
  have hlim : (inner ℂ (hA.toLp _) (hBl.toLp _) : ℂ).re ≤ 2 * ∑ j ∈ S, ‖(hEl j).toLp _‖ ^ 2 :=
    le_of_tendsto_of_tendsto' hlimL hlimR hineqN
  -- the gradient terms are bounded by `B ‖u‖`
  have hEbound : ∀ j, ‖(hEl j).toLp _‖ ≤ B * ‖u‖ := by
    intro j
    refine Lp.norm_le_mul_norm_of_ae_le_mul ?_
    filter_upwards [(hEl j).coeFn_toLp] with x hx
    rw [hx, norm_mul]
    exact mul_le_mul_of_nonneg_right (hdχ j x) (norm_nonneg _)
  -- the potential term dominates the mass
  have hmass : ‖hA.toLp _‖ ^ 2 ≤ (inner ℂ (hA.toLp _) (hBl.toLp _) : ℂ).re := by
    have hdiff : (inner ℂ (hA.toLp _) (hBl.toLp _) : ℂ) - inner ℂ (hA.toLp _) (hA.toLp _)
        = ((∫ x, (χ x) ^ 2 * (W x - 1) * ‖uf x‖ ^ 2 : ℝ) : ℂ) := by
      rw [← inner_sub_right, ← MemLp.toLp_sub, inner_toLp, ← integral_complex_ofReal]
      refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
      simp only [Pi.sub_apply]
      by_cases hx : x ∈ K
      · rw [hWloc x hx]
        have hn : (starRingEnd ℂ) (uf x) * uf x = ((‖uf x‖ ^ 2 : ℝ) : ℂ) := by
          rw [Complex.conj_mul']
          norm_cast
        simp only [map_mul, cx, Complex.conj_ofReal]
        push_cast at hn ⊢
        linear_combination ((χ x : ℂ) ^ 2 * ((W x : ℂ) - 1)) * hn
      · simp [cx, hχ0 x hx]
    have hnn : 0 ≤ ∫ x, (χ x) ^ 2 * (W x - 1) * ‖uf x‖ ^ 2 :=
      integral_nonneg fun x => by
        have := hW1 x
        have h1 : 0 ≤ W x - 1 := by linarith
        positivity
    have h2 := congrArg Complex.re hdiff
    rw [Complex.sub_re, Complex.ofReal_re] at h2
    have h3 : (inner ℂ (hA.toLp _) (hA.toLp _) : ℂ).re = ‖hA.toLp _‖ ^ 2 := by
      rw [← inner_self_eq_norm_sq (𝕜 := ℂ)]
      rfl
    linarith
  -- conclusion
  have hsum : 2 * ∑ j ∈ S, ‖(hEl j).toLp _‖ ^ 2 ≤ 2 * S.card * B ^ 2 * ‖u‖ ^ 2 := by
    have h1 : ∑ j ∈ S, ‖(hEl j).toLp _‖ ^ 2 ≤ ∑ j ∈ S, (B * ‖u‖) ^ 2 :=
      Finset.sum_le_sum fun j _ => pow_le_pow_left₀ (norm_nonneg _) (hEbound j) 2
    rw [Finset.sum_const, nsmul_eq_mul] at h1
    nlinarith
  linarith
