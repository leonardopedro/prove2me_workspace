import Mathlib
import BookProof.ChapterFockSecondQuantization

/-!
# QG-3.2 operator track — a sum of second quantizations in *differing* bases

`DESIGN_QG32_FARISLAVINE_DIFFERING_BASES.md` (plan item **QG-3.2-exec (i)** of
`CONSOLIDATED_PLAN.md`) asks for the essential self-adjointness of the lifted
coupling

```text
H_coup = Σ_ℓ dΓ(h_ℓ),
```

where the one-particle operators `h_ℓ` are positive and self-adjoint but each
diagonalizable **in its own basis**.  The design's worry is that a naive
common-alphabet rendering has to sum the pulled-back matrices
`Σ_ℓ (U_ℓ† h_ℓ U_ℓ)(p,q)` and then postulate a weighted-`ℓ¹` gate on the
resulting dense matrix — a gate that can fail precisely because the bases
differ.

This module removes that gate.  The four structural facts it proves are

* `dGamma_finsetSum_col` / `dGammaOp_finsetSum_col` — **second quantization is
  linear in the one-particle datum**: `Σ_ℓ dΓ(h_ℓ) = dΓ(Σ_ℓ h_ℓ)` on the
  finite-occupation core.  So the coupling sum is *one* second-quantized
  operator, and no common-alphabet summability gate is involved;
* `isHermCol_finsetSum`, `isPosCol_finsetSum`, `coupling_friedrichs` — the
  summed one-particle datum is again Hermitian and positive semidefinite, so
  the coupling has a positive self-adjoint (Friedrichs) extension
  unconditionally (the comparison operator of stage 2 of the design);
* `comparisonCol`, `comparison_friedrichs`, `coupling_quadForm_le`,
  `coupling_quadForm_le_comparison` — the Faris–Lavine comparison operator
  `N = Σ_ℓ dΓ(h_ℓ) + 𝒩` is positive self-adjoint (Friedrichs) and dominates
  every summand in the form sense (the relative form bound, stage 3), and
  `commForm_finsetSum` — the commutator form of a sum is the sum of the
  commutator forms (stage 4);
* `numberOp_essentiallySelfAdjoint` — the number operator `𝒩 = dΓ(1)` is
  essentially self-adjoint on the finite-occupation core;
* `coupling_esa_dGamma` — the **headline** (stage 6): if the *total*
  one-particle operator is diagonal in the working basis with non-negative
  eigenvalues `lam` (equivalently: the sum, not the individual summands, is
  diagonalized by the alphabet), then `Σ_ℓ dΓ(h_ℓ)` is essentially
  self-adjoint on the finite-occupation core.  The individual `h_ℓ` are never
  required to share a basis, and no `ℓ¹` gate on cross-basis matrix elements
  is assumed.

The bridge to the diagonal case is `dGammaOp_diagCol_eq`: over a basis
diagonalizing the total one-particle operator, `dΓ` is multiplication by the
occupation energy `occEnergy lam α = Σ_k lam k · α k` on `ℓ²(Conf)`, whose
essential self-adjointness on the finite-occupation core is
`BookProof.NavierStokesFlow.IkebeKato.ikebeKato_momentum`.

## Honest boundary

The diagonalizability of the *total* one-particle operator is a genuine
hypothesis: a positive symmetric one-particle operator need not have an
orthonormal eigenbasis, and `dΓ` of an arbitrary positive Hermitian matrix need
not be essentially self-adjoint on the finite-occupation core (only the
Friedrichs extension, `coupling_friedrichs`, is unconditional).  What is
removed here is the *differing-bases* obstruction: nothing is assumed about the
individual summands or about cross-basis matrix elements.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgCouplingDGammaSum

open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

/-! ## 1. Second quantization is linear in the one-particle datum -/

/-- The creation operator of a one-particle vector, summed over any finite set
containing its support. -/
theorem creVec_eq_sum {v : ℕ →₀ ℂ} {L : Finset ℕ} (hL : v.support ⊆ L) (x : FockAlg) :
    creVec v x = ∑ j ∈ L, v j • creA j x := by
  rw [creVec_apply]
  refine Finset.sum_subset hL fun j _ hj => ?_
  rw [Finsupp.notMem_support_iff.mp hj, zero_smul]

@[simp] theorem creVec_zero (x : FockAlg) : creVec (0 : ℕ →₀ ℂ) x = 0 := by
  simp [creVec_apply]

theorem creVec_add (v w : ℕ →₀ ℂ) (x : FockAlg) :
    creVec (v + w) x = creVec v x + creVec w x := by
  classical
  set L : Finset ℕ := (v + w).support ∪ (v.support ∪ w.support) with hL
  have h1 : (v + w).support ⊆ L := Finset.subset_union_left
  have h2 : v.support ⊆ L := fun j hj =>
    Finset.mem_union_right _ (Finset.mem_union_left _ hj)
  have h3 : w.support ⊆ L := fun j hj =>
    Finset.mem_union_right _ (Finset.mem_union_right _ hj)
  rw [creVec_eq_sum h1, creVec_eq_sum h2, creVec_eq_sum h3, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finsupp.add_apply, add_smul]

theorem creVec_finsetSum (s : Finset ι) (f : ι → (ℕ →₀ ℂ)) (x : FockAlg) :
    creVec (∑ i ∈ s, f i) x = ∑ i ∈ s, creVec (f i) x := by
  classical
  induction s using Finset.induction with
  | empty => simp
  | insert a s ha ih =>
    rw [Finset.sum_insert ha, Finset.sum_insert ha, creVec_add, ih]

/-- **Second quantization is additive in the one-particle datum.**  The sum of
the second quantizations is the second quantization of the summed one-particle
matrix — the differing bases of the summands never have to be reconciled. -/
theorem dGamma_finsetSum_col (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ)) (u : FockAlg) :
    dGamma (fun k => ∑ i ∈ s, cols i k) u = ∑ i ∈ s, dGamma (cols i) u := by
  classical
  rw [dGamma_eq_sum _ (Finset.Subset.refl (modes u))]
  have hterm : ∀ k ∈ modes u,
      creVec (∑ i ∈ s, cols i k) (annA k u) = ∑ i ∈ s, creVec (cols i k) (annA k u) :=
    fun k _ => creVec_finsetSum s (fun i => cols i k) (annA k u)
  rw [Finset.sum_congr rfl hterm, Finset.sum_comm]
  exact Finset.sum_congr rfl fun i _ =>
    (dGamma_eq_sum (cols i) (Finset.Subset.refl (modes u))).symm

/-- The Hilbert-space form of `dGamma_finsetSum_col`: on the finite-occupation
core, `Σ_ℓ dΓ(h_ℓ) = dΓ(Σ_ℓ h_ℓ)`. -/
theorem dGammaOp_finsetSum_col (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ))
    (x : lpFiniteModes Conf) :
    dGammaOp (fun k => ∑ i ∈ s, cols i k) x = ∑ i ∈ s, dGammaOp (cols i) x := by
  rw [coe_dGammaOp, dGamma_finsetSum_col]
  rw [show (∑ i ∈ s, dGamma (cols i) (fockEquiv.symm x)) =
      ∑ i ∈ s, dGamma (cols i) (fockEquiv.symm x) from rfl]
  rw [← toLpL_apply, map_sum]
  exact Finset.sum_congr rfl fun i _ => by rw [toLpL_apply, coe_dGammaOp]

/-- The same identity as an equality of linear maps on the core. -/
theorem dGammaOp_finsetSum_col_eq (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ)) :
    dGammaOp (fun k => ∑ i ∈ s, cols i k) = ∑ i ∈ s, dGammaOp (cols i) := by
  refine LinearMap.ext fun x => ?_
  rw [dGammaOp_finsetSum_col s cols x, LinearMap.sum_apply]

/-! ## 2. Hermiticity and positivity are preserved by the sum -/

theorem isHermCol_finsetSum {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)}
    (h : ∀ i ∈ s, IsHermCol (cols i)) : IsHermCol (fun k => ∑ i ∈ s, cols i k) := by
  intro j k
  simp only [Finsupp.finset_sum_apply, map_sum]
  exact Finset.sum_congr rfl fun i hi => h i hi j k

theorem isPosCol_finsetSum {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)}
    (h : ∀ i ∈ s, IsPosCol (cols i)) : IsPosCol (fun k => ∑ i ∈ s, cols i k) := by
  intro S c
  have hterm : ∀ j ∈ S, ∀ k ∈ S,
      (starRingEnd ℂ) (c j) * ((fun k => ∑ i ∈ s, cols i k) k) j * c k
        = ∑ i ∈ s, (starRingEnd ℂ) (c j) * (cols i k) j * c k := by
    intro j _ k _
    simp only [Finsupp.finset_sum_apply]
    rw [Finset.mul_sum, Finset.sum_mul]
  have hexp : (∑ j ∈ S, ∑ k ∈ S,
        (starRingEnd ℂ) (c j) * ((fun k => ∑ i ∈ s, cols i k) k) j * c k)
      = ∑ i ∈ s, ∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * (cols i k) j * c k :=
    calc (∑ j ∈ S, ∑ k ∈ S,
            (starRingEnd ℂ) (c j) * ((fun k => ∑ i ∈ s, cols i k) k) j * c k)
        = ∑ j ∈ S, ∑ k ∈ S, ∑ i ∈ s, (starRingEnd ℂ) (c j) * (cols i k) j * c k :=
          Finset.sum_congr rfl fun j hj => Finset.sum_congr rfl fun k hk => hterm j hj k hk
      _ = ∑ j ∈ S, ∑ i ∈ s, ∑ k ∈ S, (starRingEnd ℂ) (c j) * (cols i k) j * c k :=
          Finset.sum_congr rfl fun _ _ => Finset.sum_comm
      _ = ∑ i ∈ s, ∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * (cols i k) j * c k :=
          Finset.sum_comm
  rw [hexp, Complex.re_sum]
  exact Finset.sum_nonneg fun i hi => h i hi S c

/-- **Stage 2 of the design (unconditionally).**  The coupling `Σ_ℓ dΓ(h_ℓ)` of
positive Hermitian one-particle data has a positive self-adjoint (Friedrichs)
extension — no common basis, no summability gate. -/
theorem coupling_friedrichs {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)}
    (hherm : ∀ i ∈ s, IsHermCol (cols i)) (hpos : ∀ i ∈ s, IsPosCol (cols i)) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp (fun k => ∑ i ∈ s, cols i k)) A :=
  dGamma_friedrichs_extension (isHermCol_finsetSum hherm) (isPosCol_finsetSum hpos)

/-! ## 3. The relative form bound and the additivity of the commutator form -/

/-- The quadratic form of the coupling is the sum of the summands' forms. -/
theorem quadForm_dGammaOp_finsetSum (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ))
    (x : lpFiniteModes Conf) :
    quadForm (dGammaOp (fun k => ∑ i ∈ s, cols i k)) x
      = ∑ i ∈ s, quadForm (dGammaOp (cols i)) x := by
  rw [quadForm, dGammaOp_finsetSum_col s cols x, inner_sum, Complex.re_sum]
  rfl

/-- **Stage 3 of the design.**  Each summand's quadratic form is dominated by
the coupling's: the relative form bound against the comparison operator is
automatic. -/
theorem coupling_quadForm_le {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)}
    (hpos : ∀ i ∈ s, IsPosCol (cols i)) {i : ι} (hi : i ∈ s) (x : lpFiniteModes Conf) :
    quadForm (dGammaOp (cols i)) x
      ≤ quadForm (dGammaOp (fun k => ∑ j ∈ s, cols j k)) x := by
  rw [quadForm_dGammaOp_finsetSum]
  exact Finset.single_le_sum
    (fun j hj => dGammaOp_quadForm_nonneg (hpos j hj) x) hi

/-- **Stage 4 of the design.**  The commutator form of a finite sum is the sum
of the commutator forms. -/
theorem commForm_finsetSum {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    {D : Submodule ℂ F} (s : Finset ι) (H : ι → D →ₗ[ℂ] F) (N : D →ₗ[ℂ] F) (x : D) :
    commForm (∑ i ∈ s, H i) N x = ∑ i ∈ s, commForm (H i) N x := by
  classical
  simp only [commForm_eq, LinearMap.sum_apply, sum_inner, Complex.im_sum,
    Finset.mul_sum]

/-! ## 4. The diagonal total: `dΓ` is multiplication by the occupation energy -/

/-- The one-particle matrix of an operator diagonal in the working basis, with
eigenvalues `lam`. -/
def diagCol (lam : ℕ → ℝ) : ℕ → (ℕ →₀ ℂ) := fun k => Finsupp.single k (lam k : ℂ)

/-- The occupation energy of a configuration: `Σ_k lam k · α k`. -/
def occEnergy (lam : ℕ → ℝ) (α : Conf) : ℝ := ∑ k ∈ α.support, lam k * (α k : ℝ)

theorem occEnergy_nonneg {lam : ℕ → ℝ} (hlam : ∀ k, 0 ≤ lam k) (α : Conf) :
    0 ≤ occEnergy lam α :=
  Finset.sum_nonneg fun k _ => mul_nonneg (hlam k) (Nat.cast_nonneg _)

theorem creVec_single (k : ℕ) (z : ℂ) (x : FockAlg) :
    creVec (Finsupp.single k z) x = z • creA k x := by
  classical
  rcases eq_or_ne z 0 with hz | hz
  · simp [hz, creVec_apply]
  · rw [creVec_eq_sum (L := {k}) (by simp [Finsupp.support_single_ne_zero k hz])]
    simp

/-- `a_k† a_k` is multiplication by the occupation number of the mode `k`. -/
theorem creA_annA_apply (k : ℕ) (u : FockAlg) (α : Conf) :
    creA k (annA k u) α = ((α k : ℝ) : ℂ) * u α := by
  rw [creA_apply, annA_apply]
  rcases Nat.eq_zero_or_pos (α k) with h0 | hpos
  · rw [h0]
    simp
  · have hk : 1 ≤ α k := hpos
    have hdn : ((dn k α) k : ℝ) + 1 = (α k : ℝ) := by
      rw [dn_self, Nat.cast_sub (R := ℝ) hk]
      ring
    rw [hdn, up_dn k hk, ← mul_assoc, ← Complex.ofReal_mul,
      Real.mul_self_sqrt (Nat.cast_nonneg _)]

/-- **The diagonal second quantization is multiplication by the occupation
energy** on the algebraic Fock space. -/
theorem dGamma_diagCol_apply (lam : ℕ → ℝ) (u : FockAlg) (α : Conf) :
    dGamma (diagCol lam) u α = ((occEnergy lam α : ℝ) : ℂ) * u α := by
  classical
  rcases eq_or_ne (u α) 0 with hu | hu
  · rw [hu, mul_zero]
    rw [dGamma_eq_sum _ (Finset.Subset.refl (modes u))]
    have : ∀ k ∈ modes u, creVec (diagCol lam k) (annA k u) α = 0 := by
      intro k _
      rw [diagCol, creVec_single]
      simp only [Finsupp.smul_apply, smul_eq_mul, creA_annA_apply, hu, mul_zero]
    rw [Finsupp.finset_sum_apply, Finset.sum_congr rfl this, Finset.sum_const_zero]
  · have hmem : α ∈ u.support := Finsupp.mem_support_iff.mpr hu
    have hsub : α.support ⊆ modes u := support_subset_modes hmem
    rw [dGamma_eq_sum _ (Finset.Subset.refl (modes u)), Finsupp.finset_sum_apply]
    have hterm : ∀ k ∈ modes u,
        creVec (diagCol lam k) (annA k u) α = ((lam k * (α k : ℝ) : ℝ) : ℂ) * u α := by
      intro k _
      rw [diagCol, creVec_single]
      simp only [Finsupp.smul_apply, smul_eq_mul, creA_annA_apply]
      push_cast
      ring
    rw [Finset.sum_congr rfl hterm, ← Finset.sum_mul, occEnergy]
    congr 1
    rw [← Complex.ofReal_sum]
    congr 1
    refine (Finset.sum_subset hsub fun k _ hk => ?_).symm
    have hzero : α k = 0 := by simpa using hk
    rw [hzero]
    simp

/-- **The diagonal second quantization is the multiplication operator by the
occupation-energy symbol** on the finite-occupation core of `ℓ²(Conf)`. -/
theorem dGammaOp_diagCol_eq (lam : ℕ → ℝ) :
    dGammaOp (diagCol lam)
      = (diagMax (occEnergy lam)).comp
          (Submodule.inclusion (finiteModes_le_maxDom (occEnergy lam))) := by
  refine LinearMap.ext fun x => ?_
  refine lp.ext (funext fun α => ?_)
  have hx : ((x : lpFiniteModes Conf) : Fock) = toLp (fockEquiv.symm x) := coe_fockEquiv_symm x
  have hxα : ((x : lpFiniteModes Conf) : Fock) α = (fockEquiv.symm x) α := by
    rw [hx]; rfl
  rw [coe_dGammaOp]
  change (dGamma (diagCol lam) (fockEquiv.symm x)) α = _
  rw [dGamma_diagCol_apply]
  change ((occEnergy lam α : ℝ) : ℂ) * (fockEquiv.symm x) α
      = ((occEnergy lam α : ℝ) : ℂ) * (((x : lpFiniteModes Conf) : Fock) : Conf → ℂ) α
  rw [hxα]

/-- The diagonal second quantization is essentially self-adjoint on the
finite-occupation core, for every non-negative eigenvalue sequence. -/
theorem dGammaOp_diagCol_essentiallySelfAdjoint {lam : ℕ → ℝ} (hlam : ∀ k, 0 ≤ lam k) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (diagCol lam)) := by
  rw [dGammaOp_diagCol_eq]
  exact ikebeKato_momentum (occEnergy lam) (occEnergy_nonneg hlam)

/-! ## 5. The comparison operator `N = Σ_ℓ dΓ(h_ℓ) + 𝒩` -/

theorem isHermCol_diagCol (lam : ℕ → ℝ) : IsHermCol (diagCol lam) := by
  intro j k
  classical
  rcases eq_or_ne j k with h | h
  · subst h
    simp [diagCol]
  · rw [diagCol, diagCol, Finsupp.single_apply, Finsupp.single_apply, if_neg h.symm,
      if_neg h, map_zero]

theorem isPosCol_diagCol {lam : ℕ → ℝ} (hlam : ∀ k, 0 ≤ lam k) : IsPosCol (diagCol lam) := by
  intro S c
  classical
  have hinner : ∀ j ∈ S,
      (∑ k ∈ S, (starRingEnd ℂ) (c j) * (diagCol lam k) j * c k)
        = ((lam j * ‖c j‖ ^ 2 : ℝ) : ℂ) := by
    intro j hj
    have hterm : ∀ k ∈ S, (starRingEnd ℂ) (c j) * (diagCol lam k) j * c k
        = if k = j then ((lam j * ‖c j‖ ^ 2 : ℝ) : ℂ) else 0 := by
      intro k _
      rcases eq_or_ne k j with hkj | hkj
      · subst hkj
        rw [if_pos rfl, diagCol, Finsupp.single_eq_same]
        have : (starRingEnd ℂ) (c k) * c k = ((‖c k‖ ^ 2 : ℝ) : ℂ) := by
          rw [Complex.conj_mul']
          norm_cast
        rw [show (starRingEnd ℂ) (c k) * ((lam k : ℝ) : ℂ) * c k
            = ((lam k : ℝ) : ℂ) * ((starRingEnd ℂ) (c k) * c k) by ring, this,
          ← Complex.ofReal_mul]
      · rw [if_neg hkj, diagCol, Finsupp.single_apply, if_neg hkj]
        ring
    rw [Finset.sum_congr rfl hterm, Finset.sum_ite_eq' S j, if_pos hj]
  rw [Finset.sum_congr rfl hinner, Complex.re_sum]
  refine Finset.sum_nonneg fun j _ => ?_
  rw [Complex.ofReal_re]
  exact mul_nonneg (hlam j) (sq_nonneg _)

/-- The one-particle datum of the **number operator** `𝒩 = dΓ(1)`. -/
def numberCol : ℕ → (ℕ →₀ ℂ) := diagCol (fun _ => 1)

theorem isHermCol_numberCol : IsHermCol numberCol := isHermCol_diagCol _

theorem isPosCol_numberCol : IsPosCol numberCol :=
  isPosCol_diagCol (fun _ => zero_le_one)

/-- The number operator is essentially self-adjoint on the finite-occupation
core. -/
theorem numberOp_essentiallySelfAdjoint :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp numberCol) :=
  dGammaOp_diagCol_essentiallySelfAdjoint (fun _ => zero_le_one)

/-- The one-particle datum of the Faris–Lavine comparison operator
`N = Σ_ℓ h_ℓ + 1` of the design (second quantized: `Σ_ℓ dΓ(h_ℓ) + 𝒩`). -/
def comparisonCol (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ)) : ℕ → (ℕ →₀ ℂ) :=
  fun k => (∑ i ∈ s, cols i k) + numberCol k

theorem isHermCol_add {a b : ℕ → (ℕ →₀ ℂ)} (ha : IsHermCol a) (hb : IsHermCol b) :
    IsHermCol (fun k => a k + b k) := by
  intro j k
  simp only [Finsupp.add_apply, map_add]
  rw [ha j k, hb j k]

theorem isPosCol_add {a b : ℕ → (ℕ →₀ ℂ)} (ha : IsPosCol a) (hb : IsPosCol b) :
    IsPosCol (fun k => a k + b k) := by
  intro S c
  have hsplit : (∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * ((a k + b k) j) * c k)
      = (∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * (a k) j * c k)
        + ∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * (b k) j * c k := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finsupp.add_apply]
    ring
  rw [hsplit, Complex.add_re]
  exact add_nonneg (ha S c) (hb S c)

/-- **Stage 2 of the design.**  The comparison operator `N = Σ_ℓ dΓ(h_ℓ) + 𝒩`
is Hermitian and positive, hence has a positive self-adjoint (Friedrichs)
extension, for arbitrary positive Hermitian one-particle data in arbitrary
bases. -/
theorem comparison_friedrichs {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)}
    (hherm : ∀ i ∈ s, IsHermCol (cols i)) (hpos : ∀ i ∈ s, IsPosCol (cols i)) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp (comparisonCol s cols)) A :=
  dGamma_friedrichs_extension
    (isHermCol_add (isHermCol_finsetSum hherm) isHermCol_numberCol)
    (isPosCol_add (isPosCol_finsetSum hpos) isPosCol_numberCol)

theorem dGammaOp_add_col (a b : ℕ → (ℕ →₀ ℂ)) (x : lpFiniteModes Conf) :
    dGammaOp (fun k => a k + b k) x = dGammaOp a x + dGammaOp b x := by
  rw [coe_dGammaOp, coe_dGammaOp, coe_dGammaOp,
    dGamma_eq_sum _ (Finset.Subset.refl (modes (fockEquiv.symm x))),
    dGamma_eq_sum a (Finset.Subset.refl (modes (fockEquiv.symm x))),
    dGamma_eq_sum b (Finset.Subset.refl (modes (fockEquiv.symm x))),
    ← toLpL_apply, ← toLpL_apply, ← toLpL_apply, ← map_add]
  congr 1
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun k _ => creVec_add (a k) (b k) _

/-- **Stage 3 of the design, against the comparison operator.**  Each summand's
quadratic form is dominated by that of `N = Σ_ℓ dΓ(h_ℓ) + 𝒩`. -/
theorem coupling_quadForm_le_comparison {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)}
    (hpos : ∀ i ∈ s, IsPosCol (cols i)) {i : ι} (hi : i ∈ s) (x : lpFiniteModes Conf) :
    quadForm (dGammaOp (cols i)) x ≤ quadForm (dGammaOp (comparisonCol s cols)) x := by
  have hadd : quadForm (dGammaOp (comparisonCol s cols)) x
      = quadForm (dGammaOp (fun k => ∑ j ∈ s, cols j k)) x
        + quadForm (dGammaOp numberCol) x := by
    have hsplit : dGammaOp (comparisonCol s cols) x
        = dGammaOp (fun k => ∑ j ∈ s, cols j k) x + dGammaOp numberCol x :=
      dGammaOp_add_col (fun k => ∑ j ∈ s, cols j k) numberCol x
    simp only [quadForm, hsplit, inner_add_right, Complex.add_re]
  rw [hadd]
  have h1 : quadForm (dGammaOp (cols i)) x
      ≤ quadForm (dGammaOp (fun k => ∑ j ∈ s, cols j k)) x :=
    coupling_quadForm_le hpos hi x
  have h2 : 0 ≤ quadForm (dGammaOp numberCol) x :=
    dGammaOp_quadForm_nonneg isPosCol_numberCol x
  linarith

/-! ## 6. The headline: ESA of the coupling sum, bases never reconciled -/

/-- **QG-3.2-exec (i), stage 6.**  Let `h_ℓ`, `ℓ ∈ s`, be one-particle data —
each positive and self-adjoint *in its own basis*, nothing assumed about their
relative bases — whose **sum** is diagonal in the working basis with
non-negative eigenvalues `lam`.  Then the lifted coupling
`H_coup = Σ_ℓ dΓ(h_ℓ)` is essentially self-adjoint on the finite-occupation
core of the Fock space.

No weighted-`ℓ¹` gate on cross-basis matrix elements is assumed: by
`dGammaOp_finsetSum_col` the coupling *is* the second quantization of the
summed one-particle operator, and the differing bases of the summands play no
role. -/
theorem coupling_esa_dGamma {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)} {lam : ℕ → ℝ}
    (hlam : ∀ k, 0 ≤ lam k) (hdiag : (fun k => ∑ i ∈ s, cols i k) = diagCol lam) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (∑ i ∈ s, dGammaOp (cols i)) := by
  rw [← dGammaOp_finsetSum_col_eq s cols, hdiag]
  exact dGammaOp_diagCol_essentiallySelfAdjoint hlam

/-- The Friedrichs half of the headline, with no diagonalizability hypothesis:
the coupling always has a positive self-adjoint extension. -/
theorem coupling_sum_friedrichs {s : Finset ι} {cols : ι → ℕ → (ℕ →₀ ℂ)}
    (hherm : ∀ i ∈ s, IsHermCol (cols i)) (hpos : ∀ i ∈ s, IsPosCol (cols i)) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (∑ i ∈ s, dGammaOp (cols i)) A := by
  rw [← dGammaOp_finsetSum_col_eq s cols]
  exact coupling_friedrichs hherm hpos

/-! ## 7. Axiom audit -/

#print axioms dGammaOp_finsetSum_col_eq
#print axioms coupling_friedrichs
#print axioms coupling_quadForm_le
#print axioms commForm_finsetSum
#print axioms coupling_esa_dGamma
#print axioms comparison_friedrichs
#print axioms coupling_quadForm_le_comparison
#print axioms numberOp_essentiallySelfAdjoint

end

end BookProof.QgCouplingDGammaSum
