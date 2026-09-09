import Mathlib
import BookProof.ChapterSqueezedGaussStates
import BookProof.ChapterYangMillsHermite

/-!
# The abelian gauge-fixed Yang–Mills Hamiltonian has **no** one-particle form gap

`BookProof.ChapterYangMillsFockGapChain` lifts a one-particle form gap
`⟪x, H₁ x⟫ ≥ μ‖x‖²` (`μ > 0`) on the Gauss–polynomial core to a nested-Fock mass gap for
`dΓ(H₁)`.  The form gap itself is a *hypothesis* there, stated for an arbitrary family of
structure constants `fabc`.

This chapter settles the hypothesis in the **abelian case** `fabc = 0`, and settles it
negatively: for `fabc = 0`

`H₁ = ½ Σ_m π_m² + ½ Σ_{i,a} B_{i a}²`,  `B_{i a} = Σ_{j k} ε_{ijk} ∂_j A_{k,a}`,

the momenta act only in the `24` field coordinates `A_{j,a}` while the potential is a
*linear* function of the `72` independent derivative coordinates, which carry no momentum at
all.  Widening the state in the field coordinates and narrowing it in the derivative
coordinates therefore costs nothing, and the infimum of the quadratic form over the core is
`0`:

* `exists_core_state_small_energy` — for every `ε > 0` there is a nonzero core state with
  `⟪x, H₁ x⟫ ≤ ε‖x‖²`;
* `ym_abelian_no_one_particle_form_gap` — consequently the one-particle form gap fails for
  every `μ > 0`.

The two states used are the squeezed states of `BookProof.ChapterSqueezedGaussStates`: a
*wide* one (`v → ½`, small momentum) in every field coordinate and a *narrow* one
(`v → −½`, small position) in every derivative coordinate.

**Scope.**  Nothing here is claimed about the physical, non-abelian case `fabc ≠ 0`: with
non-zero structure constants the magnetic potential `ε_{ijk}(∂_jA_{k,a} + f_{abc}A_{j,b}A_{k,c})`
couples the two groups of coordinates and the above cancellation is destroyed.  What the
result does show is that no proof of the one-particle form gap can be uniform in `fabc`: the
structure constants are *essential*, and the abelian instance of the conditional chain is
vacuous.
-/

namespace BookProof.YangMillsAbelianNoGap

open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

/-! ## Real coefficients of the states -/

theorem realCoeff_one : RealCoeff (1 : MvPolynomial (Fin d) ℂ) := by
  simp [RealCoeff, starP]

theorem realCoeff_hermiteFactor (i : Fin d) (n : ℕ) : RealCoeff (hermiteFactor i n) := by
  induction n with
  | zero => rw [hermiteFactor_zero]; exact realCoeff_one
  | succ n ih =>
      rw [hermiteFactor_succ_eq, RealCoeff, starP_sub, starP_mul, starP_X, starP_pderiv,
        show starP (hermiteFactor i n) = hermiteFactor i n from ih]

theorem realCoeff_coordCombo (i : Fin d) (c : ℕ → ℝ) (p K : ℕ) :
    RealCoeff (coordCombo i c p K) := by
  refine RealCoeff.sum fun k _ => ?_
  exact RealCoeff.smul (realCoeff_hermiteFactor i _)

theorem realCoeff_prod {S : Finset (Fin d)} {f : Fin d → MvPolynomial (Fin d) ℂ}
    (h : ∀ j ∈ S, RealCoeff (f j)) : RealCoeff (∏ j ∈ S, f j) := by
  classical
  induction S using Finset.induction_on with
  | empty => simpa using realCoeff_one
  | insert a S ha ih =>
      rw [Finset.prod_insert ha]
      exact RealCoeff.mul (h a (Finset.mem_insert_self a S))
        (ih fun j hj => h j (Finset.mem_insert_of_mem hj))

/-! ## The Gaussian normalisation constant -/

/-- `∫ e^{-‖x‖²/2} dx = (2π)^{d/2}`. -/
theorem gaussInt_one_eq :
    gaussInt (1 : MvPolynomial (Fin d) ℂ) = (((Real.sqrt (2 * Real.pi)) ^ d : ℝ) : ℂ) := by
  have h0 : (monomial (0 : Fin d →₀ ℕ) (1 : ℂ)) = 1 := by simp
  have h := gaussInt_monomial (0 : Fin d →₀ ℕ)
  rw [h0] at h
  have hm : gaussMoment 0 = Real.sqrt (2 * Real.pi) := by
    simpa [gaussMoment] using BookProof.HermiteCore.gint_one
  rw [h]
  simp [hm]

theorem gaussConst_pos : (0 : ℝ) < (Real.sqrt (2 * Real.pi)) ^ d := by
  have : (0 : ℝ) < Real.sqrt (2 * Real.pi) := Real.sqrt_pos.mpr (by positivity)
  positivity

/-! ## Norms of core states from Gaussian integrals -/

theorem norm_pgLp_sq {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q) {r : ℝ}
    (h : gaussInt (q * q) = ((r : ℝ) : ℂ)) : ‖pgLp q‖ ^ 2 = r := by
  have hinner : (inner ℂ (pgLp q) (pgLp q) : ℂ) = gaussInt (starP q * q) := inner_pgLp_pgLp q q
  rw [show starP q = q from hq, h] at hinner
  have hnorm : (inner ℂ (pgLp q) (pgLp q) : ℂ) = ((‖pgLp q‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K]
    norm_cast
  rw [hnorm] at hinner
  exact_mod_cast hinner

/-! ## The product state -/

section ProductState

variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)

/-- The squeezed factor in the coordinate `j`. -/
def facW (j : Fin d) : MvPolynomial (Fin d) ℂ := squeezeState j (vf j) (Mf j)

/-- The Gaussian square norm of the factor in the coordinate `j`. -/
def facS (j : Fin d) : ℝ := coordComboSum (sqCoef (vf j) (Mf j)) 0 (Mf j)

/-- The product state: one squeezed factor per coordinate. -/
def bigP : MvPolynomial (Fin d) ℂ := ∏ j, facW vf Mf j

theorem facS_pos (j : Fin d) : 0 < facS vf Mf j := by
  have h : coordComboSum (sqCoef (vf j) (Mf j)) 0 (Mf j) = Vsum (vf j) (Mf j) :=
    coordComboSum_sqCoef _ _
  rw [facS, h]
  linarith [Vsum_ge_one (vf j) (Mf j)]

theorem coordFactor_facW (j : Fin d) : CoordFactor j (facW vf Mf j) (facS vf Mf j) :=
  coordFactor_coordCombo j (sqCoef (vf j) (Mf j)) 0 (Mf j)

theorem realCoeff_facW (j : Fin d) : RealCoeff (facW vf Mf j) :=
  realCoeff_coordCombo j _ _ _

theorem realCoeff_bigP : RealCoeff (bigP vf Mf) :=
  realCoeff_prod fun j _ => realCoeff_facW vf Mf j

theorem gaussInt_bigP :
    gaussInt (bigP vf Mf * bigP vf Mf)
      = (((∏ j, facS vf Mf j) * (Real.sqrt (2 * Real.pi)) ^ d : ℝ) : ℂ) := by
  have h := gaussInt_prod_coordFactor (S := (Finset.univ : Finset (Fin d)))
    (W := facW vf Mf) (s := facS vf Mf) (fun j _ => coordFactor_facW vf Mf j)
    (R := 1) (fun j _ => by simp)
  rw [mul_one] at h
  rw [bigP, h, gaussInt_one_eq]
  push_cast
  ring

theorem norm_bigP_sq :
    ‖pgLp (bigP vf Mf)‖ ^ 2 = (∏ j, facS vf Mf j) * (Real.sqrt (2 * Real.pi)) ^ d :=
  norm_pgLp_sq (realCoeff_bigP vf Mf) (gaussInt_bigP vf Mf)

theorem norm_bigP_pos : 0 < ‖pgLp (bigP vf Mf)‖ ^ 2 := by
  rw [norm_bigP_sq]
  have hprod : 0 < ∏ j, facS vf Mf j :=
    Finset.prod_pos fun j _ => facS_pos vf Mf j
  have := gaussConst_pos (d := d)
  positivity

/-- The image of the product state under `α x_c + γ ∂_c` is again a product state, with the
`c`-th factor replaced by an odd Hermite combination. -/
theorem op_bigP (c : Fin d) (α γ : ℝ) :
    ((α : ℝ) : ℂ) • (X c * bigP vf Mf) + ((γ : ℝ) : ℂ) • pderiv c (bigP vf Mf)
      = coordCombo c (opCoef α γ (vf c) (Mf c)) 1 (Mf c)
        * ∏ j ∈ Finset.univ.erase c, facW vf Mf j := by
  classical
  set R : MvPolynomial (Fin d) ℂ := ∏ j ∈ Finset.univ.erase c, facW vf Mf j with hR
  have hsplit : bigP vf Mf = facW vf Mf c * R := by
    rw [bigP, hR, ← Finset.mul_prod_erase _ _ (Finset.mem_univ c)]
  have hpR : pderiv c R = 0 := by
    refine pderiv_prod_eq_zero (fun j hj => ?_)
    exact (coordFactor_facW vf Mf j).1 c (fun h => (Finset.ne_of_mem_erase hj) h.symm)
  have hder : pderiv c (bigP vf Mf) = pderiv c (facW vf Mf c) * R := by
    rw [hsplit, Derivation.leibniz, hpR]
    simp [smul_eq_mul, mul_comm]
  rw [hder, hsplit, show facW vf Mf c = squeezeState c (vf c) (Mf c) from rfl,
    ← op_squeezeState c α γ (vf c) (Mf c)]
  simp only [smul_eq_C_mul]
  ring

theorem gaussInt_op_bigP (c : Fin d) (α γ : ℝ) :
    gaussInt ((((α : ℝ) : ℂ) • (X c * bigP vf Mf) + ((γ : ℝ) : ℂ) • pderiv c (bigP vf Mf))
        * (((α : ℝ) : ℂ) • (X c * bigP vf Mf) + ((γ : ℝ) : ℂ) • pderiv c (bigP vf Mf)))
      = (((coordComboSum (opCoef α γ (vf c) (Mf c)) 1 (Mf c))
          * (∏ j ∈ Finset.univ.erase c, facS vf Mf j)
          * (Real.sqrt (2 * Real.pi)) ^ d : ℝ) : ℂ) := by
  classical
  set u : MvPolynomial (Fin d) ℂ := coordCombo c (opCoef α γ (vf c) (Mf c)) 1 (Mf c) with hu
  set R : MvPolynomial (Fin d) ℂ := ∏ j ∈ Finset.univ.erase c, facW vf Mf j with hR
  have hCFu : CoordFactor c u (coordComboSum (opCoef α γ (vf c) (Mf c)) 1 (Mf c)) :=
    coordFactor_coordCombo c _ _ _
  have hRR : gaussInt (R * (R * 1))
      = (((∏ j ∈ Finset.univ.erase c, facS vf Mf j) : ℝ) : ℂ) * gaussInt 1 :=
    gaussInt_prod_coordFactor (fun j _ => coordFactor_facW vf Mf j) (fun j _ => by simp)
  have hpRR : pderiv c (R * (R * 1)) = 0 := by
    have hpR : pderiv c R = 0 := by
      refine pderiv_prod_eq_zero (fun j hj => ?_)
      exact (coordFactor_facW vf Mf j).1 c (fun h => (Finset.ne_of_mem_erase hj) h.symm)
    rw [Derivation.leibniz, hpR, Derivation.leibniz, hpR]
    simp
  have hkey := hCFu.2 (R * (R * 1)) hpRR
  rw [op_bigP vf Mf c α γ, ← hu, ← hR]
  have hrw : (u * R) * (u * R) = u * (u * (R * (R * 1))) := by ring
  rw [hrw, hkey, hRR, gaussInt_one_eq]
  push_cast
  ring

theorem norm_op_bigP_sq (c : Fin d) (α γ : ℝ) :
    ‖pgLp (((α : ℝ) : ℂ) • (X c * bigP vf Mf) + ((γ : ℝ) : ℂ) • pderiv c (bigP vf Mf))‖ ^ 2
      = (coordComboSum (opCoef α γ (vf c) (Mf c)) 1 (Mf c))
        * (∏ j ∈ Finset.univ.erase c, facS vf Mf j) * (Real.sqrt (2 * Real.pi)) ^ d := by
  refine norm_pgLp_sq ?_ (gaussInt_op_bigP vf Mf c α γ)
  refine RealCoeff.add (RealCoeff.smul ?_) (RealCoeff.smul ?_)
  · exact RealCoeff.mul (realCoeff_X c) (realCoeff_bigP vf Mf)
  · rw [RealCoeff, starP_pderiv, show starP (bigP vf Mf) = bigP vf Mf from realCoeff_bigP vf Mf]

/-- **The per-coordinate energy bound.** -/
theorem norm_op_bigP_le (c : Fin d) (α γ ε : ℝ)
    (h : coordComboSum (opCoef α γ (vf c) (Mf c)) 1 (Mf c) ≤ ε * facS vf Mf c) :
    ‖pgLp (((α : ℝ) : ℂ) • (X c * bigP vf Mf) + ((γ : ℝ) : ℂ) • pderiv c (bigP vf Mf))‖ ^ 2
      ≤ ε * ‖pgLp (bigP vf Mf)‖ ^ 2 := by
  classical
  have hprod : (∏ j, facS vf Mf j)
      = facS vf Mf c * ∏ j ∈ Finset.univ.erase c, facS vf Mf j :=
    (Finset.mul_prod_erase _ _ (Finset.mem_univ c)).symm
  have hrest : 0 ≤ ∏ j ∈ Finset.univ.erase c, facS vf Mf j :=
    Finset.prod_nonneg fun j _ => (facS_pos vf Mf j).le
  have hG : (0 : ℝ) ≤ (Real.sqrt (2 * Real.pi)) ^ d := (gaussConst_pos (d := d)).le
  rw [norm_op_bigP_sq, norm_bigP_sq, hprod]
  have hfactor : 0 ≤ (∏ j ∈ Finset.univ.erase c, facS vf Mf j)
      * (Real.sqrt (2 * Real.pi)) ^ d := mul_nonneg hrest hG
  nlinarith [h, hfactor]

end ProductState

/-! ## The abelian Yang–Mills energy of the product state -/

theorem abs_levi_le_one (i j k : Fin 3) : |levi i j k| ≤ 1 := by
  fin_cases i <;> fin_cases j <;> fin_cases k <;> norm_num [levi]

/-- With vanishing structure constants the magnetic field is linear in the derivative
coordinates. -/
theorem magPoly_abelian (i : Fin 3) (a : Fin 8) :
    magPoly (fun _ _ _ => 0) i a
      = ∑ j : Fin 3, ∑ k : Fin 3, ((levi i j k : ℝ) : ℂ) • X (idxD j k a) := by
  rw [magPoly]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
  simp

theorem idxA_lt (j : Fin 3) (a : Fin 8) : ((idxA j a : Fin 99) : ℕ) < 27 := by
  have hj : (j : ℕ) < 3 := j.isLt
  have ha : (a : ℕ) < 8 := a.isLt
  simp only [idxA]
  omega

theorem idxD_ge (j k : Fin 3) (a : Fin 8) : 27 ≤ ((idxD j k a : Fin 99) : ℕ) := by
  simp only [idxD]
  omega

/-- The parameter assignment: the *wide* squeezing parameter in the `3 + 24` spatial and field
coordinates, the *narrow* one in the `72` derivative coordinates. -/
def vsel (v₁ v₂ : ℝ) (j : Fin 99) : ℝ := if (j : ℕ) < 27 then v₁ else v₂

/-- The truncation order attached to each coordinate by `vsel`. -/
def Msel (M₁ M₂ : ℕ) (j : Fin 99) : ℕ := if (j : ℕ) < 27 then M₁ else M₂

theorem vsel_idxA (v₁ v₂ : ℝ) (j : Fin 3) (a : Fin 8) : vsel v₁ v₂ (idxA j a) = v₁ :=
  if_pos (idxA_lt j a)

theorem Msel_idxA (M₁ M₂ : ℕ) (j : Fin 3) (a : Fin 8) : Msel M₁ M₂ (idxA j a) = M₁ :=
  if_pos (idxA_lt j a)

theorem vsel_idxD (v₁ v₂ : ℝ) (j k : Fin 3) (a : Fin 8) : vsel v₁ v₂ (idxD j k a) = v₂ :=
  if_neg (by have := idxD_ge j k a; omega)

theorem Msel_idxD (M₁ M₂ : ℕ) (j k : Fin 3) (a : Fin 8) : Msel M₁ M₂ (idxD j k a) = M₂ :=
  if_neg (by have := idxD_ge j k a; omega)

/-- A square bound transfers to a bound on the norms. -/
theorem le_of_sq_le {a t b : ℝ} (ht : 0 ≤ t) (hb : 0 ≤ b)
    (h : a ^ 2 ≤ t ^ 2 * b ^ 2) : a ≤ t * b := by
  have h' : a ^ 2 ≤ (t * b) ^ 2 := by rw [mul_pow]; exact h
  exact le_of_sq_le_sq h' (by positivity)

set_option maxHeartbeats 2000000 in
-- The proof assembles 24 momentum and 24 magnetic coordinate bounds inside the 99-variable
-- Gauss-polynomial core, so the elaboration exceeds the default heartbeat budget.
/-- **The quadratic form of the abelian gauge-fixed Yang–Mills Hamiltonian has infimum `0` on
the Gauss–polynomial core.**  For every `ε > 0` there is a nonzero core state whose energy is
at most `ε‖x‖²`. -/
theorem exists_core_state_small_energy (e : ℕ ≃ (Fin 99 →₀ ℕ)) {ε : ℝ} (hε : 0 < ε) :
    ∃ x : finiteModeDomain (coreBasis e), ((x : L2d 99) ≠ 0) ∧
      quadForm (ymHamiltonian (coreRepBasis e) (fun _ _ _ => (0 : ℝ))) x
        ≤ ε * ‖(x : L2d 99)‖ ^ 2 := by
  classical
  obtain ⟨v₁, M₁, -, h₁⟩ := exists_momentum_small (ε := ε / 24) (by positivity)
  obtain ⟨v₂, M₂, -, h₂⟩ := exists_position_small (ε := ε / 2000) (by positivity)
  set vf : Fin 99 → ℝ := vsel v₁ v₂ with hvf
  set Mf : Fin 99 → ℕ := Msel M₁ M₂ with hMf
  set P : MvPolynomial (Fin 99) ℂ := bigP vf Mf with hP
  set x : finiteModeDomain (coreBasis e) := (coreRepBasis e).equiv P with hx
  have hxc : ((x : finiteModeDomain (coreBasis e)) : L2d 99) = pgLp P :=
    (coreRepBasis e).coe_equiv P
  have hxs : (coreRepBasis e).equiv.symm x = P := LinearEquiv.symm_apply_apply _ _
  have hPpos : 0 < ‖pgLp P‖ ^ 2 := norm_bigP_pos vf Mf
  -- the momentum terms
  have hpi : ∀ m : Fin 24,
      ‖((piOps (coreRepBasis e) m x : finiteModeDomain (coreBasis e)) : L2d 99)‖ ^ 2
        ≤ (ε / 24) * ‖pgLp P‖ ^ 2 := by
    intro m
    set c : Fin 99 := idxA (decodeSpace m) (decodeColor m) with hc
    have hcoe : ((piOps (coreRepBasis e) m x : finiteModeDomain (coreBasis e)) : L2d 99)
        = pgLp (momOp c P) := by
      rw [piOps, CoreRep.coe_op, hxs]
    have hmom : momOp c P
        = (-Complex.I) • ((((-(1 / 2) : ℝ)) : ℂ) • (X c * P) + (((1 : ℝ)) : ℂ) • pderiv c P) := by
      rw [momOp_apply]
      push_cast
      module
    have hnorm : ‖pgLp (momOp c P)‖
        = ‖pgLp ((((-(1 / 2) : ℝ)) : ℂ) • (X c * P) + (((1 : ℝ)) : ℂ) • pderiv c P)‖ := by
      rw [hmom, ← pgMap_apply, map_smul, pgMap_apply, norm_smul]
      simp
    rw [hcoe, hnorm]
    refine norm_op_bigP_le vf Mf c (-(1 / 2)) 1 (ε / 24) ?_
    have hv : vf c = v₁ := by rw [hvf, hc, vsel_idxA]
    have hM : Mf c = M₁ := by rw [hMf, hc, Msel_idxA]
    rw [facS, hv, hM]
    exact h₁
  -- the magnetic terms
  set t : ℝ := Real.sqrt (ε / 2000) with ht
  have ht0 : 0 ≤ t := Real.sqrt_nonneg _
  have ht2 : t ^ 2 = ε / 2000 := Real.sq_sqrt (by positivity)
  have hXD : ∀ (j k : Fin 3) (a : Fin 8),
      ‖pgLp (X (idxD j k a) * P)‖ ≤ t * ‖pgLp P‖ := by
    intro j k a
    set c : Fin 99 := idxD j k a with hc
    have hbound : ‖pgLp ((((1 : ℝ)) : ℂ) • (X c * P) + (((0 : ℝ)) : ℂ) • pderiv c P)‖ ^ 2
        ≤ (ε / 2000) * ‖pgLp P‖ ^ 2 := by
      refine norm_op_bigP_le vf Mf c 1 0 (ε / 2000) ?_
      have hv : vf c = v₂ := by rw [hvf, hc, vsel_idxD]
      have hM : Mf c = M₂ := by rw [hMf, hc, Msel_idxD]
      rw [facS, hv, hM]
      exact h₂
    have hsimp : (((1 : ℝ)) : ℂ) • (X c * P) + (((0 : ℝ)) : ℂ) • pderiv c P = X c * P := by
      push_cast
      module
    rw [hsimp] at hbound
    refine le_of_sq_le ht0 (norm_nonneg _) ?_
    rw [ht2]
    exact hbound
  have hB : ∀ m : Fin 24,
      ‖((magOps (coreRepBasis e) (fun _ _ _ => (0 : ℝ)) m x :
          finiteModeDomain (coreBasis e)) : L2d 99)‖ ^ 2
        ≤ 81 * (ε / 2000) * ‖pgLp P‖ ^ 2 := by
    intro m
    set i : Fin 3 := decodeSpace m with hi
    set a : Fin 8 := decodeColor m with ha
    have hcoe : ((magOps (coreRepBasis e) (fun _ _ _ => (0 : ℝ)) m x :
        finiteModeDomain (coreBasis e)) : L2d 99)
        = pgLp (magPoly (fun _ _ _ => (0 : ℝ)) i a * P) := by
      rw [magOps, CoreRep.coe_op, hxs, mulOp_apply]
    have hexp : magPoly (fun _ _ _ => (0 : ℝ)) i a * P
        = ∑ j : Fin 3, ∑ k : Fin 3, ((levi i j k : ℝ) : ℂ) • (X (idxD j k a) * P) := by
      rw [magPoly_abelian, Finset.sum_mul]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [smul_mul_assoc]
    have hsum : pgLp (∑ j : Fin 3, ∑ k : Fin 3, ((levi i j k : ℝ) : ℂ) • (X (idxD j k a) * P))
        = ∑ j : Fin 3, ∑ k : Fin 3,
            ((levi i j k : ℝ) : ℂ) • pgLp (X (idxD j k a) * P) := by
      rw [← pgMap_apply, map_sum]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [map_sum]
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [map_smul, pgMap_apply]
    have hnorm : ‖pgLp (magPoly (fun _ _ _ => (0 : ℝ)) i a * P)‖ ≤ 9 * (t * ‖pgLp P‖) := by
      rw [hexp, hsum]
      have hstep : ∀ j : Fin 3,
          ‖∑ k : Fin 3, ((levi i j k : ℝ) : ℂ) • pgLp (X (idxD j k a) * P)‖
            ≤ 3 * (t * ‖pgLp P‖) := by
        intro j
        refine le_trans (norm_sum_le _ _) ?_
        have hterm : ∀ k : Fin 3, ‖((levi i j k : ℝ) : ℂ) • pgLp (X (idxD j k a) * P)‖
            ≤ t * ‖pgLp P‖ := by
          intro k
          rw [norm_smul]
          have h1 : ‖((levi i j k : ℝ) : ℂ)‖ ≤ 1 := by
            simpa [Complex.norm_real] using abs_levi_le_one i j k
          have h2 : ‖pgLp (X (idxD j k a) * P)‖ ≤ t * ‖pgLp P‖ := hXD j k a
          have h3 : (0 : ℝ) ≤ ‖pgLp (X (idxD j k a) * P)‖ := norm_nonneg _
          nlinarith [norm_nonneg ((((levi i j k : ℝ) : ℂ))), h3]
        calc ∑ k : Fin 3, ‖((levi i j k : ℝ) : ℂ) • pgLp (X (idxD j k a) * P)‖
            ≤ ∑ _k : Fin 3, t * ‖pgLp P‖ := Finset.sum_le_sum fun k _ => hterm k
          _ = 3 * (t * ‖pgLp P‖) := by simp
      refine le_trans (norm_sum_le _ _) ?_
      calc ∑ j : Fin 3, ‖∑ k : Fin 3, ((levi i j k : ℝ) : ℂ) • pgLp (X (idxD j k a) * P)‖
          ≤ ∑ _j : Fin 3, 3 * (t * ‖pgLp P‖) := Finset.sum_le_sum fun j _ => hstep j
        _ = 9 * (t * ‖pgLp P‖) := by simp; ring
    rw [hcoe]
    have hnn : 0 ≤ ‖pgLp (magPoly (fun _ _ _ => (0 : ℝ)) i a * P)‖ := norm_nonneg _
    have hrhs : 0 ≤ 9 * (t * ‖pgLp P‖) := by positivity
    nlinarith [hnorm, hnn, ht2, norm_nonneg (pgLp P)]
  -- assemble
  refine ⟨x, ?_, ?_⟩
  · rw [hxc]
    intro hzero
    rw [hzero] at hPpos
    simp at hPpos
  · rw [ymHamiltonian_quadForm, hxc]
    have hs1 : (∑ m : Fin 24,
        ‖((piOps (coreRepBasis e) m x : finiteModeDomain (coreBasis e)) : L2d 99)‖ ^ 2)
          ≤ 24 * ((ε / 24) * ‖pgLp P‖ ^ 2) := by
      calc (∑ m : Fin 24,
          ‖((piOps (coreRepBasis e) m x : finiteModeDomain (coreBasis e)) : L2d 99)‖ ^ 2)
          ≤ ∑ _m : Fin 24, (ε / 24) * ‖pgLp P‖ ^ 2 := Finset.sum_le_sum fun m _ => hpi m
        _ = 24 * ((ε / 24) * ‖pgLp P‖ ^ 2) := by simp
    have hs2 : (∑ m : Fin 24,
        ‖((magOps (coreRepBasis e) (fun _ _ _ => (0 : ℝ)) m x :
            finiteModeDomain (coreBasis e)) : L2d 99)‖ ^ 2)
          ≤ 24 * (81 * (ε / 2000) * ‖pgLp P‖ ^ 2) := by
      calc (∑ m : Fin 24,
          ‖((magOps (coreRepBasis e) (fun _ _ _ => (0 : ℝ)) m x :
              finiteModeDomain (coreBasis e)) : L2d 99)‖ ^ 2)
          ≤ ∑ _m : Fin 24, 81 * (ε / 2000) * ‖pgLp P‖ ^ 2 := Finset.sum_le_sum fun m _ => hB m
        _ = 24 * (81 * (ε / 2000) * ‖pgLp P‖ ^ 2) := by simp
    nlinarith [hs1, hs2, hPpos]

/-- **The abelian one-particle form gap fails.**  For every `μ > 0` the hypothesis consumed by
`BookProof.YangMillsFockGapChain.ym_fock_mass_gap_of_one_particle_form_gap` is false when the
structure constants vanish. -/
theorem ym_abelian_no_one_particle_form_gap (e : ℕ ≃ (Fin 99 →₀ ℕ)) {mu : ℝ} (hmu : 0 < mu) :
    ¬ ∀ x : finiteModeDomain (coreBasis e),
      mu * ‖(x : L2d 99)‖ ^ 2
        ≤ quadForm (ymHamiltonian (coreRepBasis e) (fun _ _ _ => (0 : ℝ))) x := by
  intro hgap
  obtain ⟨x, hx0, hxle⟩ := exists_core_state_small_energy e (ε := mu / 2) (by positivity)
  have hnorm : 0 < ‖(x : L2d 99)‖ ^ 2 := by
    have : (0 : ℝ) < ‖(x : L2d 99)‖ := norm_pos_iff.mpr hx0
    positivity
  have h := hgap x
  nlinarith [h, hxle, hnorm]

end

end BookProof.YangMillsAbelianNoGap
