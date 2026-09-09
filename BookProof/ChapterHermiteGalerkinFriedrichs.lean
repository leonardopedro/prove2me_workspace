import Mathlib
import BookProof.ChapterYangMillsFriedrichsLimit

/-!
# The Hermite-basis Galerkin (Rayleigh–Ritz) truncation and the Friedrichs extension

This module formalizes the argument that a Krylov/Galerkin algorithm run in a
complete basis (the Hermite/oscillator basis) does not have to be told which
self-adjoint extension of a semi-bounded symmetric Hamiltonian to use: the
truncation is a Rayleigh–Ritz minimization of the *energy form*, and the
sequence of finite-dimensional energy minimizations converges to the extension
determined by the energy form — the Friedrichs extension.

The informal argument has three steps; here is what each becomes.

**Step 1 (the Rayleigh–Ritz connection).**  Truncating to the span of the first
`m` basis vectors replaces `H` by the compression `Pₘ H Pₘ`, and on that
subspace the compression carries *exactly* the energy form of `H`
(`inner_galerkinCompression`, `quadForm_galerkinCompression`).  The
associated Ritz values are the infima of the energy over unit vectors of the
subspace; they are antitone in `m` (`ritzInf_antitone`) and converge to the
infimum of the energy form over the whole domain
(`ritzInf_tendsto_domainInf`).  Moreover that limit dominates the ground-state
energy of *every* positive self-adjoint extension (`ritzInf_extension_le`), the
extension attaining it being the one whose energy form is the closure of the
form of `H` — the Friedrichs extension.  **No boundedness is used here.**

**Step 2 (the flag exhausts the form domain).**  For the Hermite basis the
domain is the span of the basis vectors, and *every* domain vector already lies
in a finite Galerkin subspace (`exists_mem_galerkinSpan`), while the subspaces
increase to a dense subspace (`galerkinSpan_iSup_dense`), so the projections
converge strongly to the identity (`galerkinProj_tendsto`).  This is the
formal content of "`Pₘ → I` because the Hermite functions are complete", and of
"the finite matrices explore larger and larger subspaces of the energy form".

**Step 3 (the limit is the Friedrichs extension).**  In the regime where the
operator is bounded on its domain — the regime in which the limit of the
truncations exists as an operator, and the only regime claimed here — we prove:

* the compressions converge strongly to the extension
  (`galerkinCompression_tendsto`, `compression_tendsto_of_starProjection_tendsto`);
* the *resolvents* of the truncations converge strongly to the resolvent of the
  extension, for every non-real spectral parameter
  (`resolvent_tendsto_of_strong_tendsto`, `galerkinResolvent_tendsto`) — this is
  the Galerkin/Rayleigh–Ritz strong-resolvent-convergence statement quoted in
  the informal argument;
* the extension so obtained is the **unique** positive self-adjoint extension
  (`positive_selfadjoint_extension_unique`), i.e. the algorithm has no freedom
  left: what it converges to is the Friedrichs extension.

The headline combination is `hermiteGalerkin_selects_friedrichs`.

## Scope — what is *not* claimed

* Everything in Step 3 carries an explicit boundedness hypothesis on the
  operator, exactly as in `BookProof.ChapterYangMillsFriedrichsLimit`.  For a
  genuinely unbounded, non-essentially-self-adjoint operator the identification
  of the Galerkin limit with the Friedrichs extension is **not** proved here;
  only Steps 1 and 2 (the variational content) are unconditional.
* Nothing about the indeterminate Stieltjes moment problem, Padé approximants or
  Nevanlinna-extremal measures is formalized.
* The Hermite basis enters through the property that actually matters — it is a
  Hilbert basis indexed by `ℕ`, so its finite spans increase to a dense
  subspace.  No property of Hermite polynomials beyond completeness and
  orthonormality is used, and the results apply verbatim to any complete
  orthonormal basis.
-/

namespace BookProof.HermiteGalerkin

open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

/-! ## Step 2, general form: projections onto an increasing dense flag -/

section Flag

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **A monotone flag with dense union projects to the identity.**  If the
subspaces `K n` increase and their union is dense, then the orthogonal
projections `Pₙ` converge strongly to the identity.  (For the Hermite basis this
is "the Hermite functions are complete", `galerkinProj_tendsto`.) -/
theorem starProjection_tendsto_of_monotone_dense (K : ℕ → Submodule ℂ F)
    [∀ n, (K n).HasOrthogonalProjection] (hmono : Monotone K)
    (hdense : Dense ((⨆ n : ℕ, K n : Submodule ℂ F) : Set F)) (u : F) :
    Tendsto (fun n : ℕ => (K n).starProjection u) atTop (nhds u) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  rw [Metric.tendsto_atTop]
  intro eps heps
  obtain ⟨w, hw, hwd⟩ := hdense.exists_dist_lt u heps
  obtain ⟨N, hN⟩ := (Submodule.mem_iSup_of_directed _ hmono.directed_le).mp hw
  refine ⟨N, fun n hn => ?_⟩
  have h1 : ‖u - (K n).starProjection u‖ ≤ ‖u - w‖ :=
    BookProof.ChapterH9.norm_sub_starProjection_le _ u w (hmono hn hN)
  have h2 : ‖u - w‖ < eps := by simpa [dist_eq_norm] using hwd
  have h3 : ‖(K n).starProjection u - u‖ = ‖u - (K n).starProjection u‖ := norm_sub_rev _ _
  simp only [Real.dist_eq, sub_zero, abs_of_nonneg (norm_nonneg _), h3]
  exact lt_of_le_of_lt h1 h2

/-- **Compressions of a bounded operator converge strongly.**  If the orthogonal
projections `Pₙ` converge strongly to the identity, then `Pₙ A Pₙ → A` strongly
for every bounded `A`. -/
theorem compression_tendsto_of_starProjection_tendsto (K : ℕ → Submodule ℂ F)
    [∀ n, (K n).HasOrthogonalProjection] (A : F →L[ℂ] F)
    (hP : ∀ u : F, Tendsto (fun n : ℕ => (K n).starProjection u) atTop (nhds u)) (u : F) :
    Tendsto (fun n : ℕ => (K n).starProjection (A ((K n).starProjection u)))
      atTop (nhds (A u)) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hbound : ∀ n : ℕ, ‖(K n).starProjection (A ((K n).starProjection u)) - A u‖
      ≤ ‖A‖ * ‖(K n).starProjection u - u‖ + ‖(K n).starProjection (A u) - A u‖ := by
    intro n
    have hsplit : (K n).starProjection (A ((K n).starProjection u)) - A u
        = (K n).starProjection (A ((K n).starProjection u) - A u)
          + ((K n).starProjection (A u) - A u) := by
      simp only [map_sub]
      abel
    rw [hsplit]
    refine le_trans (norm_add_le _ _) ?_
    gcongr
    refine le_trans ((K n).norm_starProjection_apply_le _) ?_
    have hAsub : A ((K n).starProjection u) - A u = A ((K n).starProjection u - u) := by
      rw [map_sub]
    rw [hAsub]
    exact A.le_opNorm _
  have h1 : Tendsto (fun n : ℕ => ‖A‖ * ‖(K n).starProjection u - u‖) atTop (nhds 0) := by
    have := hP u
    rw [tendsto_iff_norm_sub_tendsto_zero] at this
    simpa using this.const_mul ‖A‖
  have h2 : Tendsto (fun n : ℕ => ‖(K n).starProjection (A u) - A u‖) atTop (nhds 0) := by
    have := hP (A u)
    rw [tendsto_iff_norm_sub_tendsto_zero] at this
    simpa using this
  exact squeeze_zero (fun n => norm_nonneg _) hbound (by simpa using h1.add h2)

end Flag

/-! ## The Galerkin flag of a Hilbert basis (the Hermite basis) -/

section Galerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The span of the first `m` basis vectors: the subspace the algorithm works in
at step `m`.  For the Hermite basis this is the space of polynomials of degree
`< m` times the Gaussian. -/
noncomputable def galerkinSpan (b : HilbertBasis ℕ ℂ F) (m : ℕ) : Submodule ℂ F :=
  Submodule.span ℂ (b '' {i | i < m})

instance galerkinSpan_finiteDimensional (b : HilbertBasis ℕ ℂ F) (m : ℕ) :
    FiniteDimensional ℂ (galerkinSpan b m) :=
  FiniteDimensional.span_of_finite ℂ ((Set.finite_Iio m).image _)

theorem galerkinSpan_mono (b : HilbertBasis ℕ ℂ F) {m n : ℕ} (hmn : m ≤ n) :
    galerkinSpan b m ≤ galerkinSpan b n :=
  Submodule.span_mono (Set.image_mono fun _ hi => lt_of_lt_of_le hi hmn)

theorem basis_mem_galerkinSpan (b : HilbertBasis ℕ ℂ F) {i m : ℕ} (him : i < m) :
    b i ∈ galerkinSpan b m :=
  Submodule.subset_span ⟨i, him, rfl⟩

/-- **The finite-mode domain**: the span of all the basis vectors — the space of
all finite linear combinations of Hermite functions, which is where the matrix
elements `⟨Hermiteᵢ | H | Hermiteⱼ⟩` are computed. -/
noncomputable def finiteModeDomain (b : HilbertBasis ℕ ℂ F) : Submodule ℂ F :=
  Submodule.span ℂ (Set.range b)

theorem galerkinSpan_le_finiteModeDomain (b : HilbertBasis ℕ ℂ F) (m : ℕ) :
    galerkinSpan b m ≤ finiteModeDomain b :=
  Submodule.span_mono (by rintro x ⟨i, _, rfl⟩; exact ⟨i, rfl⟩)

theorem finiteModeDomain_eq_iSup (b : HilbertBasis ℕ ℂ F) :
    finiteModeDomain b = ⨆ m : ℕ, galerkinSpan b m := by
  refine le_antisymm ?_ (iSup_le fun m => galerkinSpan_le_finiteModeDomain b m)
  rw [finiteModeDomain, Submodule.span_le]
  rintro x ⟨i, rfl⟩
  exact Submodule.mem_iSup_of_mem (i + 1) (basis_mem_galerkinSpan b (Nat.lt_succ_self i))

/-- **Every vector of the finite-mode domain already lives in a finite Galerkin
subspace.**  The Galerkin flag therefore exhausts the domain on which the energy
form is given, with no limiting process at all. -/
theorem exists_mem_galerkinSpan (b : HilbertBasis ℕ ℂ F) {x : F} (hx : x ∈ finiteModeDomain b) :
    ∃ m : ℕ, x ∈ galerkinSpan b m := by
  rw [finiteModeDomain_eq_iSup] at hx
  have hmono : Monotone (fun m : ℕ => galerkinSpan b m) := fun _ _ h => galerkinSpan_mono b h
  have hdir : Directed (· ≤ ·) (fun m : ℕ => galerkinSpan b m) := hmono.directed_le
  exact (Submodule.mem_iSup_of_directed _ hdir).mp hx

/-- **The Hermite basis is complete**: the finite-mode domain is dense. -/
theorem finiteModeDomain_dense (b : HilbertBasis ℕ ℂ F) :
    Dense ((finiteModeDomain b : Submodule ℂ F) : Set F) :=
  Submodule.dense_iff_topologicalClosure_eq_top.mpr b.dense_span

theorem galerkinSpan_iSup_dense (b : HilbertBasis ℕ ℂ F) :
    Dense ((⨆ m : ℕ, galerkinSpan b m : Submodule ℂ F) : Set F) := by
  rw [← finiteModeDomain_eq_iSup]
  exact finiteModeDomain_dense b

/-- **`Pₘ → I` strongly.**  The Galerkin projections of a Hilbert basis converge
strongly to the identity — the hypothesis "`Pₘ → I` because the Hermite
polynomials are a complete basis" of the informal argument. -/
theorem galerkinProj_tendsto (b : HilbertBasis ℕ ℂ F) (u : F) :
    Tendsto (fun m : ℕ => (galerkinSpan b m).starProjection u) atTop (nhds u) :=
  starProjection_tendsto_of_monotone_dense _ (fun _ _ h => galerkinSpan_mono b h)
    (galerkinSpan_iSup_dense b) u

/-- The **Galerkin (Rayleigh–Ritz) compression** `Pₘ A Pₘ` of a bounded operator
in the basis `b`: the `m × m` matrix the algorithm actually diagonalizes, read
back as an operator on the whole space. -/
noncomputable def galerkinCompression (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) (m : ℕ) :
    F →L[ℂ] F :=
  (galerkinSpan b m).starProjection ∘L A ∘L (galerkinSpan b m).starProjection

@[simp] theorem galerkinCompression_apply (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) (m : ℕ)
    (u : F) : galerkinCompression A b m u
      = (galerkinSpan b m).starProjection (A ((galerkinSpan b m).starProjection u)) := rfl

/-- **The compressions converge strongly to the operator.** -/
theorem galerkinCompression_tendsto (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) (u : F) :
    Tendsto (fun m : ℕ => galerkinCompression A b m u) atTop (nhds (A u)) :=
  compression_tendsto_of_starProjection_tendsto _ A (galerkinProj_tendsto b) u

end Galerkin

/-! ## Step 1 — the Rayleigh–Ritz connection: the compression carries the energy
form -/

section RayleighRitz

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **The Galerkin matrix is the energy form restricted to the subspace.**  For
`u` in the truncation subspace, `⟪u, Pₘ A Pₘ u⟫ = ⟪u, A u⟫`: diagonalizing the
finite matrix *is* minimizing the energy over the subspace. -/
theorem inner_galerkinCompression (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) (m : ℕ)
    {u : F} (hu : u ∈ galerkinSpan b m) :
    (inner ℂ u (galerkinCompression A b m u) : ℂ) = inner ℂ u (A u) := by
  have hfix : (galerkinSpan b m).starProjection u = u :=
    Submodule.starProjection_eq_self_iff.mpr hu
  rw [galerkinCompression_apply, hfix,
    ← Submodule.inner_starProjection_left_eq_right, hfix]

theorem quadForm_galerkinCompression (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) (m : ℕ)
    {u : F} (hu : u ∈ galerkinSpan b m) :
    (inner ℂ u (galerkinCompression A b m u) : ℂ).re = (inner ℂ u (A u) : ℂ).re := by
  rw [inner_galerkinCompression A b m hu]

variable {D : Submodule ℂ F}

/-- The set of **Ritz values** available at truncation level `V`: the energies
`⟪ψ, Hψ⟫` of the unit vectors `ψ` of `V`.  The algorithm's ground-state estimate
at that level is the infimum of this set. -/
def ritzSet (H : D →ₗ[ℂ] F) (V : Submodule ℂ F) : Set ℝ :=
  {t : ℝ | ∃ x : D, (x : F) ∈ V ∧ ‖(x : F)‖ = 1 ∧ t = quadForm H x}

theorem ritzSet_mono (H : D →ₗ[ℂ] F) {V W : Submodule ℂ F} (hVW : V ≤ W) :
    ritzSet H V ⊆ ritzSet H W := by
  rintro t ⟨x, hxV, hx1, rfl⟩
  exact ⟨x, hVW hxV, hx1, rfl⟩

theorem ritzSet_bddBelow (H : D →ₗ[ℂ] F) (hpos : ∀ x : D, 0 ≤ quadForm H x)
    (V : Submodule ℂ F) : BddBelow (ritzSet H V) := by
  refine ⟨0, ?_⟩
  rintro t ⟨x, _, _, rfl⟩
  exact hpos x

/-- The **Ritz value** at truncation level `V`: the Rayleigh–Ritz minimum of the
energy over the unit sphere of `V`. -/
noncomputable def ritzInf (H : D →ₗ[ℂ] F) (V : Submodule ℂ F) : ℝ := sInf (ritzSet H V)

/-- **Rayleigh–Ritz monotonicity**: enlarging the truncation subspace can only
lower the energy minimum. -/
theorem ritzInf_antitone (H : D →ₗ[ℂ] F) (hpos : ∀ x : D, 0 ≤ quadForm H x)
    {V W : Submodule ℂ F} (hVW : V ≤ W) (hV : (ritzSet H V).Nonempty) :
    ritzInf H W ≤ ritzInf H V :=
  csInf_le_csInf (ritzSet_bddBelow H hpos W) hV (ritzSet_mono H hVW)

theorem ritzInf_nonneg (H : D →ₗ[ℂ] F) (hpos : ∀ x : D, 0 ≤ quadForm H x)
    (V : Submodule ℂ F) (hV : (ritzSet H V).Nonempty) : 0 ≤ ritzInf H V :=
  le_csInf hV (by rintro t ⟨x, _, _, rfl⟩; exact hpos x)

/-- **The Rayleigh–Ritz values converge to the bottom of the energy form.**
For a positive symmetric operator on the finite-mode (Hermite) domain, the
ground-state estimates produced by the truncations decrease to the infimum of
the energy form over the whole domain — the bottom of the Friedrichs form.
No boundedness hypothesis is used. -/
theorem ritzInf_tendsto_domainInf (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x) :
    Tendsto (fun m : ℕ => ritzInf H (galerkinSpan b (m + 1))) atTop
      (nhds (ritzInf H (finiteModeDomain b))) := by
  set a : ℕ → ℝ := fun m => ritzInf H (galerkinSpan b (m + 1)) with ha
  -- the first basis vector is a unit vector of every truncation subspace
  have hb0mem : b 0 ∈ finiteModeDomain b := Submodule.subset_span ⟨0, rfl⟩
  have hb0norm : ‖b 0‖ = 1 := b.orthonormal.1 0
  have hne : ∀ m : ℕ, (ritzSet H (galerkinSpan b (m + 1))).Nonempty := by
    intro m
    refine ⟨quadForm H ⟨b 0, hb0mem⟩, ⟨b 0, hb0mem⟩, ?_, hb0norm, rfl⟩
    exact galerkinSpan_mono b (Nat.succ_le_succ (Nat.zero_le m))
      (basis_mem_galerkinSpan b Nat.zero_lt_one)
  have hsub : ∀ m : ℕ, ritzSet H (galerkinSpan b (m + 1)) ⊆ ritzSet H (finiteModeDomain b) :=
    fun m => ritzSet_mono H (galerkinSpan_le_finiteModeDomain b (m + 1))
  -- the sequence of Ritz values is antitone and bounded below
  have hanti : Antitone a := by
    intro p q hpq
    exact ritzInf_antitone H hpos (galerkinSpan_mono b (Nat.succ_le_succ hpq)) (hne p)
  have hnonneg : ∀ m : ℕ, 0 ≤ a m := fun m => ritzInf_nonneg H hpos _ (hne m)
  have hbdd : BddBelow (Set.range a) := ⟨0, by rintro t ⟨m, rfl⟩; exact hnonneg m⟩
  have hlim := tendsto_atTop_ciInf hanti hbdd
  -- and its limit is the infimum of the energy over the whole domain
  have hSne : (ritzSet H (finiteModeDomain b)).Nonempty := (hne 0).mono (hsub 0)
  have hkey : (⨅ m : ℕ, a m) = ritzInf H (finiteModeDomain b) := by
    refine le_antisymm ?_ ?_
    · refine le_csInf hSne ?_
      rintro t ⟨x, _, hx1, rfl⟩
      obtain ⟨m, hm⟩ := exists_mem_galerkinSpan b x.2
      have hmem : quadForm H x ∈ ritzSet H (galerkinSpan b (m + 1)) :=
        ⟨x, galerkinSpan_mono b (Nat.le_succ m) hm, hx1, rfl⟩
      refine le_trans (ciInf_le hbdd m) ?_
      exact csInf_le (ritzSet_bddBelow H hpos _) hmem
    · refine le_ciInf fun m => ?_
      exact csInf_le_csInf (ritzSet_bddBelow H hpos _) (hne m) (hsub m)
  rw [← hkey]
  exact hlim

/-- **Every positive self-adjoint extension sits below the Rayleigh–Ritz
limit.**  The energy form of an extension `A` restricted to the original domain
is the energy form of `H`, so the infimum of the energy of `A` over its own
domain is at most the infimum of the energy of `H`.  Combined with
`ritzInf_tendsto_domainInf`, the number the algorithm converges to is an upper
bound for the ground-state energy of *every* extension; the extension that
attains it is the one whose energy form is the closure of the form of `H` — the
Friedrichs extension.  No boundedness hypothesis is used. -/
theorem ritzInf_extension_le {Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F) (A : Dom →ₗ[ℂ] F)
    (hA : IsPositiveSelfAdjointExtension H A) (hne : (ritzSet H D).Nonempty) :
    ritzInf A Dom ≤ ritzInf H D := by
  refine csInf_le_csInf (ritzSet_bddBelow A hA.2.2.1 Dom) hne ?_
  rintro t ⟨x, -, hx1, rfl⟩
  obtain ⟨hmem, hval⟩ := hA.1 x
  refine ⟨⟨(x : F), hmem⟩, (⟨(x : F), hmem⟩ : Dom).2, hx1, ?_⟩
  simp only [quadForm, hval]

end RayleighRitz

/-! ## Step 3 — resolvents: strong resolvent convergence of the truncations -/

section Resolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- For a bounded self-adjoint operator and a non-real `z`, the operator
`z - T` is bounded below by `|Im z|`. -/
theorem norm_sub_smul_ge (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) (z : ℂ) (u : F) :
    |z.im| * ‖u‖ ≤ ‖(algebraMap ℂ (F →L[ℂ] F) z - T) u‖ := by
  have h : (inner ℂ (T u) u : ℂ) = inner ℂ u (T u) :=
    (ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hT) u u
  have hsym : (inner ℂ u (T u) : ℂ).im = 0 := by
    refine Complex.conj_eq_iff_im.mp ?_
    rw [inner_conj_symm]
    exact h
  have happ : (algebraMap ℂ (F →L[ℂ] F) z - T) u = z • u - T u := by
    simp [Algebra.algebraMap_eq_smul_one]
  have hinner : (inner ℂ u ((algebraMap ℂ (F →L[ℂ] F) z - T) u) : ℂ).im = z.im * ‖u‖ ^ 2 := by
    rw [happ, inner_sub_right, inner_smul_right, inner_self_eq_norm_sq_to_K, Complex.sub_im,
      hsym, sub_zero, Complex.mul_im]
    simp [← Complex.ofReal_pow]
  have hcs : |(inner ℂ u ((algebraMap ℂ (F →L[ℂ] F) z - T) u) : ℂ).im|
      ≤ ‖u‖ * ‖(algebraMap ℂ (F →L[ℂ] F) z - T) u‖ :=
    le_trans (Complex.abs_im_le_norm _) (norm_inner_le_norm _ _)
  rw [hinner] at hcs
  rcases eq_or_lt_of_le (norm_nonneg u) with h0 | hpos
  · simp [← h0]
  · rw [abs_mul, abs_of_nonneg (by positivity : (0:ℝ) ≤ ‖u‖ ^ 2)] at hcs
    nlinarith [hcs, hpos]

/-- A non-real number is not in the spectrum of a bounded self-adjoint
operator. -/
theorem isUnit_algebraMap_sub (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) {z : ℂ} (hz : z.im ≠ 0) :
    IsUnit (algebraMap ℂ (F →L[ℂ] F) z - T) := by
  have hspec : z ∉ spectrum ℂ T := by
    intro hmem
    exact hz (by rw [← hT.spectrumRestricts.rightInvOn hmem]; simp)
  simpa [spectrum.mem_iff] using hspec

/-- The resolvent is a right inverse of `z - T`. -/
theorem sub_resolvent_apply (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) {z : ℂ} (hz : z.im ≠ 0)
    (w : F) : (algebraMap ℂ (F →L[ℂ] F) z - T) (resolvent T z w) = w := by
  have hmul : (algebraMap ℂ (F →L[ℂ] F) z - T) * resolvent T z = 1 :=
    Ring.mul_inverse_cancel _ (isUnit_algebraMap_sub T hT hz)
  calc (algebraMap ℂ (F →L[ℂ] F) z - T) (resolvent T z w)
      = ((algebraMap ℂ (F →L[ℂ] F) z - T) * resolvent T z) w := rfl
    _ = w := by rw [hmul]; rfl

/-- The resolvent bound `‖(z - T)⁻¹‖ ≤ 1/|Im z|` for a bounded self-adjoint
operator. -/
theorem norm_resolvent_apply_le (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) {z : ℂ} (hz : z.im ≠ 0)
    (w : F) : |z.im| * ‖resolvent T z w‖ ≤ ‖w‖ := by
  have h := norm_sub_smul_ge T hT z (resolvent T z w)
  rwa [sub_resolvent_apply T hT hz w] at h

/-- **Strong resolvent convergence.**  If bounded self-adjoint operators `Tₙ`
converge strongly to a bounded self-adjoint `A`, then their resolvents converge
strongly to the resolvent of `A`, at every non-real spectral parameter.  This is
the Galerkin/Rayleigh–Ritz convergence statement of the informal argument. -/
theorem resolvent_tendsto_of_strong_tendsto (T : ℕ → F →L[ℂ] F) (A : F →L[ℂ] F)
    (hT : ∀ n, IsSelfAdjoint (T n)) (hA : IsSelfAdjoint A) {z : ℂ} (hz : z.im ≠ 0)
    (hconv : ∀ u : F, Tendsto (fun n : ℕ => T n u) atTop (nhds (A u))) (u : F) :
    Tendsto (fun n : ℕ => resolvent (T n) z u) atTop (nhds (resolvent A z u)) := by
  have hzpos : 0 < |z.im| := abs_pos.mpr hz
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hbound : ∀ n : ℕ, ‖resolvent (T n) z u - resolvent A z u‖
      ≤ ‖T n (resolvent A z u) - A (resolvent A z u)‖ / |z.im| := by
    intro n
    have hSn : resolvent (T n) z * (algebraMap ℂ (F →L[ℂ] F) z - T n) = 1 :=
      Ring.inverse_mul_cancel _ (isUnit_algebraMap_sub (T n) (hT n) hz)
    have hS : (algebraMap ℂ (F →L[ℂ] F) z - A) * resolvent A z = 1 :=
      Ring.mul_inverse_cancel _ (isUnit_algebraMap_sub A hA hz)
    have hsub : (T n - A)
        = (algebraMap ℂ (F →L[ℂ] F) z - A) - (algebraMap ℂ (F →L[ℂ] F) z - T n) := by abel
    have hid : resolvent (T n) z - resolvent A z
        = resolvent (T n) z * (T n - A) * resolvent A z := by
      rw [hsub, mul_sub, sub_mul, mul_assoc, hS, hSn]
      simp
    have happ : resolvent (T n) z u - resolvent A z u
        = resolvent (T n) z (T n (resolvent A z u) - A (resolvent A z u)) := by
      have := congrArg (fun S : F →L[ℂ] F => S u) hid
      simpa using this
    rw [happ, le_div_iff₀ hzpos, mul_comm]
    exact norm_resolvent_apply_le (T n) (hT n) hz _
  have hconv0 : Tendsto
      (fun n : ℕ => ‖T n (resolvent A z u) - A (resolvent A z u)‖ / |z.im|) atTop (nhds 0) := by
    have h := hconv (resolvent A z u)
    rw [tendsto_iff_norm_sub_tendsto_zero] at h
    simpa using h.div_const |z.im|
  exact squeeze_zero (fun n => norm_nonneg _) hbound hconv0

end Resolvent

/-! ## The two steps combined: what the algorithm selects -/

section Selection

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- The Galerkin compression of a self-adjoint operator is self-adjoint. -/
theorem isSelfAdjoint_galerkinCompression {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    (b : HilbertBasis ℕ ℂ F) (m : ℕ) : IsSelfAdjoint (galerkinCompression A b m) := by
  have hP : IsSelfAdjoint (galerkinSpan b m).starProjection :=
    isSelfAdjoint_starProjection _
  change star ((galerkinSpan b m).starProjection * A * (galerkinSpan b m).starProjection)
    = (galerkinSpan b m).starProjection * A * (galerkinSpan b m).starProjection
  rw [star_mul, star_mul, hP.star_eq, hA.star_eq, mul_assoc]

/-- **The truncated resolvents converge to the resolvent of the limit
operator.**  `(Pₘ A Pₘ - z)⁻¹ → (A - z)⁻¹` strongly for every non-real `z`. -/
theorem galerkinResolvent_tendsto {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    (b : HilbertBasis ℕ ℂ F) {z : ℂ} (hz : z.im ≠ 0) (u : F) :
    Tendsto (fun m : ℕ => resolvent (galerkinCompression A b m) z u) atTop
      (nhds (resolvent A z u)) :=
  resolvent_tendsto_of_strong_tendsto _ A (fun m => isSelfAdjoint_galerkinCompression hA b m) hA
    hz (galerkinCompression_tendsto A b) u

/-- **The positive self-adjoint extension of a bounded densely defined symmetric
operator is unique.**  Any extension in the sense of
`IsPositiveSelfAdjointExtension` defined on the whole space agrees with the
continuous extension.  (Symmetric everywhere-defined operators are automatically
continuous — Hellinger–Toeplitz — and two continuous maps agreeing on a dense
set agree.)  So in this regime there is no ambiguity to resolve: the operator
the algorithm converges to *is* the Friedrichs extension. -/
theorem positive_selfadjoint_extension_unique {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (A : F →L[ℂ] F) (hAH : ∀ x : D, A (x : F) = H x)
    (B : (⊤ : Submodule ℂ F) →ₗ[ℂ] F) (hB : IsPositiveSelfAdjointExtension H B) (x : F) :
    B ⟨x, trivial⟩ = A x := by
  -- read `B` as an everywhere-defined linear map
  set B' : F →ₗ[ℂ] F := B.comp (Submodule.topEquiv (R := ℂ) (M := F)).symm.toLinearMap with hB'
  have hB'apply : ∀ y : F, B' y = B ⟨y, trivial⟩ := fun y => rfl
  -- it is symmetric, hence continuous (Hellinger–Toeplitz)
  have hB'sym : B'.IsSymmetric := by
    intro y w
    have := hB.2.1 ⟨y, trivial⟩ ⟨w, trivial⟩
    simpa [hB'apply] using this
  have hB'cont : Continuous B' := hB'sym.continuous
  -- and it agrees with `A` on the dense domain
  have hagree : ∀ y ∈ (D : Set F), B' y = A y := by
    intro y hy
    obtain ⟨h, hval⟩ := hB.1 ⟨y, hy⟩
    rw [hB'apply, hAH ⟨y, hy⟩, ← hval]
  have := Continuous.ext_on hdense hB'cont A.continuous hagree
  exact (hB'apply x) ▸ congrFun this x

/-- **The headline.**  Let `H` be a symmetric, positive operator given by its
matrix elements in a complete orthonormal (Hermite) basis, on the domain of
finite linear combinations of basis vectors, and bounded there.  Then there is a
bounded operator `A` such that

1. `A` extends `H` (`hext`) and is a positive self-adjoint extension of it
   (`hpse`) — and it is the *only* one (`huniq`), i.e. it is the Friedrichs
   extension;
2. the Galerkin/Rayleigh–Ritz truncations `Pₘ A Pₘ` converge to `A` strongly
   (`hstrong`);
3. their resolvents converge to the resolvent of `A` at every non-real spectral
   parameter (`hres`).

No boundary condition is imposed anywhere: the basis and the variational
truncation select the extension. -/
theorem hermiteGalerkin_selects_friedrichs (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn (finiteModeDomain b) H)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x)
    (C : ℝ) (hbd : ∀ x : finiteModeDomain b, ‖H x‖ ≤ C * ‖(x : F)‖) :
    ∃ A : F →L[ℂ] F,
      (∀ x : finiteModeDomain b, A (x : F) = H x) ∧
      IsPositiveSelfAdjointExtension H (topRestrict A) ∧
      (∀ (B : (⊤ : Submodule ℂ F) →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H B →
        ∀ x : F, B ⟨x, trivial⟩ = A x) ∧
      (∀ u : F, Tendsto (fun m : ℕ => galerkinCompression A b m u) atTop (nhds (A u))) ∧
      (∀ (z : ℂ), z.im ≠ 0 → ∀ u : F,
        Tendsto (fun m : ℕ => resolvent (galerkinCompression A b m) z u) atTop
          (nhds (resolvent A z u))) := by
  obtain ⟨A, hagree, hext⟩ :=
    friedrichs_of_bounded H (finiteModeDomain_dense b) hsym hpos C hbd
  have hAsa : IsSelfAdjoint A := by
    refine ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mpr ?_
    intro y w
    have := hext.2.1 ⟨y, trivial⟩ ⟨w, trivial⟩
    simpa [topRestrict] using this
  refine ⟨A, hagree, hext, ?_, ?_, ?_⟩
  · intro B hBext x
    exact positive_selfadjoint_extension_unique H (finiteModeDomain_dense b) A hagree B hBext x
  · exact fun u => galerkinCompression_tendsto A b u
  · exact fun z hz u => galerkinResolvent_tendsto hAsa b hz u

end Selection

/-! ## The hypotheses are not vacuous, and the domain is genuinely proper -/

section Examples

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- The restriction of a bounded operator to the finite-mode (Hermite) domain:
the operator the algorithm sees, namely the matrix `⟨bᵢ | A₀ | bⱼ⟩`. -/
noncomputable def finiteModeRestrict (A₀ : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) :
    finiteModeDomain b →ₗ[ℂ] F :=
  A₀.toLinearMap.comp (finiteModeDomain b).subtype

omit [CompleteSpace F] in
@[simp] theorem finiteModeRestrict_apply (A₀ : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    (x : finiteModeDomain b) : finiteModeRestrict A₀ b x = A₀ (x : F) := rfl

/-- **The hypotheses of `hermiteGalerkin_selects_friedrichs` are satisfiable.**
The restriction to the finite-mode domain of any bounded positive self-adjoint
operator is symmetric, positive and bounded there. -/
theorem finiteModeRestrict_hypotheses (A₀ : F →L[ℂ] F) (hsa : IsSelfAdjoint A₀)
    (hposA : ∀ u : F, 0 ≤ (inner ℂ u (A₀ u) : ℂ).re) (b : HilbertBasis ℕ ℂ F) :
    SymmetricOn (finiteModeDomain b) (finiteModeRestrict A₀ b) ∧
      (∀ x : finiteModeDomain b, 0 ≤ quadForm (finiteModeRestrict A₀ b) x) ∧
      (∀ x : finiteModeDomain b, ‖finiteModeRestrict A₀ b x‖ ≤ ‖A₀‖ * ‖(x : F)‖) := by
  refine ⟨fun x y => ?_, fun x => hposA _, fun x => A₀.le_opNorm _⟩
  exact (ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hsa) (x : F) (y : F)

/-- **What the algorithm converges to is the operator itself.**  Feed the matrix
elements of a bounded positive self-adjoint `A₀` in the basis `b` to the
Galerkin/Hashimoto algorithm.  The extension it selects is `A₀`; it is the only
positive self-adjoint extension of the matrix; and both the compressions and
their resolvents converge strongly to those of `A₀`. -/
theorem finiteModeRestrict_selects_operator (A₀ : F →L[ℂ] F) (hsa : IsSelfAdjoint A₀)
    (hposA : ∀ u : F, 0 ≤ (inner ℂ u (A₀ u) : ℂ).re) (b : HilbertBasis ℕ ℂ F) :
    IsPositiveSelfAdjointExtension (finiteModeRestrict A₀ b) (topRestrict A₀) ∧
      (∀ (B : (⊤ : Submodule ℂ F) →ₗ[ℂ] F),
        IsPositiveSelfAdjointExtension (finiteModeRestrict A₀ b) B →
        ∀ x : F, B ⟨x, trivial⟩ = A₀ x) ∧
      (∀ u : F, Tendsto (fun m : ℕ => galerkinCompression A₀ b m u) atTop (nhds (A₀ u))) ∧
      (∀ z : ℂ, z.im ≠ 0 → ∀ u : F,
        Tendsto (fun m : ℕ => resolvent (galerkinCompression A₀ b m) z u) atTop
          (nhds (resolvent A₀ z u))) := by
  obtain ⟨hsym, hpos, hbd⟩ := finiteModeRestrict_hypotheses A₀ hsa hposA b
  obtain ⟨A, hagree, hext, huniq, -, -⟩ :=
    hermiteGalerkin_selects_friedrichs b (finiteModeRestrict A₀ b) hsym hpos ‖A₀‖ hbd
  -- the constructed extension is `A₀` itself
  have hAA : A = A₀ := by
    ext u
    have := Continuous.ext_on (finiteModeDomain_dense b) A.continuous A₀.continuous
      (fun y hy => by simpa using hagree ⟨y, hy⟩)
    exact congrFun this u
  subst hAA
  exact ⟨hext, huniq, fun u => galerkinCompression_tendsto A b u,
    fun z hz u => galerkinResolvent_tendsto hsa b hz u⟩

end Examples

section ProperDomain

open scoped InnerProductSpace ENNReal

/-- The canonical Hilbert basis of `ℓ²(ℕ, ℂ)` — the abstract model of the
Hermite basis of `L²(ℝ)`. -/
noncomputable def ell2Basis : HilbertBasis ℕ ℂ (ℓ²(ℕ, ℂ)) :=
  HilbertBasis.ofRepr (LinearIsometryEquiv.refl ℂ _)

/-- **The finite-mode domain is a *proper* dense subspace.**  So the theorems
above are not about the degenerate case of an operator already defined
everywhere: in `ℓ²(ℕ, ℂ)` the span of the basis (all finite linear combinations
of Hermite functions) misses every vector of infinite support. -/
theorem finiteModeDomain_ne_top : finiteModeDomain ell2Basis ≠ ⊤ := by
  set x : ℓ²(ℕ, ℂ) := ⟨fun n : ℕ => (1 / (n + 1) : ℂ), memℓp_one_div_succ⟩ with hx
  have hcoeff : ∀ i, ell2Basis.repr x i ≠ 0 := by
    intro i
    have hxi : (ell2Basis.repr x : ℕ → ℂ) i = 1 / ((i : ℂ) + 1) := rfl
    rw [hxi]
    have hne : ((i : ℂ) + 1) ≠ 0 := by
      rw [show ((i : ℂ) + 1) = (((i + 1 : ℕ) : ℂ)) by push_cast; ring]
      exact_mod_cast Nat.succ_ne_zero i
    simpa using hne
  have hnot : x ∉ finiteModeDomain ell2Basis :=
    not_mem_span_of_repr_ne_zero ell2Basis x hcoeff
  intro htop
  exact hnot (by rw [htop]; trivial)

end ProperDomain

end BookProof.HermiteGalerkin
