import Mathlib
import BookProof.ChapterNavierStokesFullEsa

/-!
# Second quantization of an essentially self-adjoint one-particle operator

This module supplies the *Fock-space* half of the essential-self-adjointness
argument for the Navier–Stokes Hamiltonian: the passage from a one-particle
comparison operator to its second quantization.

The Fock space is modelled, as in Reed–Simon Vol. I §II.4, as the Hilbert direct
sum `⨁ₘ Sₘ` of the `m`-particle sectors, realized concretely as `lp S 2`.  The
*finite-particle domain* `fockCore D` consists of the states with finitely many
non-zero sectors, each of them lying in the sector domain `D m`; when every
`D m` is dense this is a dense subspace of the Fock space (`fockCore_dense`), and
for infinitely many nontrivial sectors it is a *proper* one
(`fockCore_ne_top`).

A sector-wise family of operators `A m : D m →ₗ[ℂ] D m` assembles into the
operator `fockOp A` on the finite-particle domain — this is `dΓ` written in
sectors, `dΓ(a)` acting on the `m`-particle sector as `∑_{k<m} a_k`.  The
headline result is

* `fockOp_hasZeroDeficiencyOn`: **if every sector operator is essentially
  self-adjoint on its sector domain, then the second quantization is essentially
  self-adjoint on the finite-particle domain.**

This is the direct-sum half of the second-quantization theorem
(Reed–Simon Vol. I, Theorem VIII.33 / §VIII.10).  The remaining half — that the
`m`-particle sector operator `∑_{k<m} a_k` is essentially self-adjoint on the
algebraic tensor power of a core for `a` — is *not* proved here in that
generality; what is proved (`sectorOfEigenbasis_hasZeroDeficiencyOn` in the
companion module, and `BookProof.NavierStokesFlow.FockOfFock.dGamma_hasZeroDeficiencyOn`
already in the project) is the case in which the one-particle operator is
diagonalized by a total family of eigenvectors, which is the situation of the
Navier–Stokes comparison operator in the fiber momentum representation.

## Scope

Nothing here claims essential self-adjointness of the continuum Navier–Stokes
generator, nor global existence for Navier–Stokes.  This module is about the
Fock-space bookkeeping: what sector-wise essential self-adjointness gives, and
what it does not.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace SecondQuant

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]

/-! ## The Fock space as a Hilbert direct sum of sectors -/

omit [∀ m, InnerProductSpace ℂ (S m)] in
/-- A family with finitely many non-zero members is square-summable. -/
theorem memℓp_of_finite_support {g : ∀ m, S m}
    (h : (Function.support fun m => ‖g m‖).Finite) : Memℓp g 2 := by
  apply memℓp_gen
  refine summable_of_ne_finset_zero (s := h.toFinset) ?_
  intro m hm
  have : ‖g m‖ = 0 := by
    by_contra hne
    exact hm (h.mem_toFinset.mpr (by simpa [Function.mem_support] using hne))
  simp [this]

/-- The Fock state built from a family of sector states with finitely many
non-zero members. -/
noncomputable def ofSectors (g : ∀ m, S m) (h : (Function.support fun m => ‖g m‖).Finite) :
    lp S 2 :=
  ⟨g, memℓp_of_finite_support h⟩

omit [∀ m, InnerProductSpace ℂ (S m)] in
@[simp] theorem ofSectors_apply (g : ∀ m, S m) (h : (Function.support fun m => ‖g m‖).Finite)
    (m : ι) : (ofSectors g h : ∀ m, S m) m = g m := rfl

variable (D : ∀ m, Submodule ℂ (S m))

/-- **The finite-particle domain of the Fock space.**  States with finitely many
non-zero sectors, each sector state lying in the sector domain `D m`.  This is
`𝓕_fin(D)`. -/
def fockCore : Submodule ℂ (lp S 2) where
  carrier :=
    {f | (Function.support fun m => ‖(f : ∀ m, S m) m‖).Finite ∧ ∀ m, (f : ∀ m, S m) m ∈ D m}
  add_mem' := by
    rintro f g ⟨hf, hfD⟩ ⟨hg, hgD⟩
    constructor
    · refine (hf.union hg).subset ?_
      intro m hm
      by_contra hcon
      simp only [Set.mem_union, Function.mem_support, not_or, not_not] at hcon
      have h1 : (f : ∀ m, S m) m = 0 := by simpa using hcon.1
      have h2 : (g : ∀ m, S m) m = 0 := by simpa using hcon.2
      exact hm (by simp [h1, h2])
    · intro m
      simpa [lp.coeFn_add] using Submodule.add_mem _ (hfD m) (hgD m)
  zero_mem' := by
    refine ⟨?_, ?_⟩ <;> simp
  smul_mem' := by
    rintro c f ⟨hf, hfD⟩
    constructor
    · refine hf.subset ?_
      intro m hm
      simp only [Function.mem_support, lp.coeFn_smul, Pi.smul_apply, norm_smul] at hm ⊢
      intro hzero
      exact hm (by simp [hzero])
    · intro m
      simpa [lp.coeFn_smul] using Submodule.smul_mem _ c (hfD m)

variable {D}

@[simp] theorem mem_fockCore {f : lp S 2} :
    f ∈ fockCore D ↔
      (Function.support fun m => ‖(f : ∀ m, S m) m‖).Finite ∧ ∀ m, (f : ∀ m, S m) m ∈ D m :=
  Iff.rfl

/-- A one-sector state lies in the finite-particle domain. -/
theorem single_mem_fockCore [DecidableEq ι] (m : ι) (x : S m) (hx : x ∈ D m) :
    lp.single 2 m x ∈ fockCore D := by
  have hne_zero : ∀ {j : ι}, j ≠ m → ((lp.single 2 m x : lp S 2) : ∀ j, S j) j = 0 := by
    intro j hj
    exact lp.single_apply_ne 2 m x hj
  constructor
  · refine (Set.finite_singleton m).subset ?_
    intro j hj
    simp only [Function.mem_support] at hj
    by_contra hcon
    have hjm : j ≠ m := by simpa using hcon
    exact hj (by rw [hne_zero hjm]; simp)
  · intro j
    rcases eq_or_ne j m with rfl | hjm
    · simpa [lp.single_apply_self] using hx
    · rw [hne_zero hjm]
      exact (D j).zero_mem

/-! ### Density of the finite-particle domain -/

/-- If every sector domain is dense, the finite-particle domain is dense in the
Fock space. -/
theorem fockCore_dense (hD : ∀ m, Dense ((D m : Submodule ℂ (S m)) : Set (S m))) :
    Dense ((fockCore D : Submodule ℂ (lp S 2)) : Set (lp S 2)) := by
  classical
  rw [Metric.dense_iff]
  intro f r hr
  -- first approximate `f` by a finite sector truncation
  have hsum := lp.hasSum_single (E := S) (p := 2) (by simp) f
  obtain ⟨s, hs⟩ :=
    (hsum.eventually (Metric.ball_mem_nhds f (by linarith : (0:ℝ) < r / 2))).exists
  -- then approximate each of the finitely many sector states from `D m`
  have hchoice : ∀ m : ι, ∃ y ∈ ((D m : Submodule ℂ (S m)) : Set (S m)),
      dist ((f : ∀ m, S m) m) y < r / (2 * ((s.card : ℝ) + 1)) := by
    intro m
    have hpos : 0 < r / (2 * ((s.card : ℝ) + 1)) := by positivity
    have hmem : (f : ∀ m, S m) m ∈ closure ((D m : Submodule ℂ (S m)) : Set (S m)) := by
      rw [(hD m).closure_eq]; trivial
    exact Metric.mem_closure_iff.mp hmem _ hpos
  choose y hyD hy using hchoice
  refine ⟨∑ m ∈ s, lp.single 2 m (y m), ?_, ?_⟩
  · -- the approximant is within `r` of `f`
    have hdiff : ‖(∑ m ∈ s, lp.single 2 m ((f : ∀ m, S m) m)) - ∑ m ∈ s, lp.single 2 m (y m)‖
        ≤ ∑ m ∈ s, ‖(f : ∀ m, S m) m - y m‖ := by
      rw [← Finset.sum_sub_distrib]
      refine (norm_sum_le _ _).trans (le_of_eq (Finset.sum_congr rfl fun m _ => ?_))
      rw [← lp.single_sub]
      exact lp.norm_single (by norm_num) m _
    have hbound : ∑ m ∈ s, ‖(f : ∀ m, S m) m - y m‖ < r / 2 := by
      have hlt : ∀ m ∈ s, ‖(f : ∀ m, S m) m - y m‖ ≤ r / (2 * ((s.card : ℝ) + 1)) := by
        intro m _
        have h := hy m
        rw [dist_eq_norm] at h
        exact h.le
      have hcalc : ∑ m ∈ s, ‖(f : ∀ m, S m) m - y m‖
          ≤ (s.card : ℝ) * (r / (2 * ((s.card : ℝ) + 1))) := by
        calc ∑ m ∈ s, ‖(f : ∀ m, S m) m - y m‖
            ≤ ∑ _m ∈ s, r / (2 * ((s.card : ℝ) + 1)) := Finset.sum_le_sum hlt
          _ = (s.card : ℝ) * (r / (2 * ((s.card : ℝ) + 1))) := by simp [mul_comm]
      have heq : (s.card : ℝ) * (r / (2 * ((s.card : ℝ) + 1)))
          = (r / 2) * ((s.card : ℝ) / ((s.card : ℝ) + 1)) := by
        have hc : ((s.card : ℝ) + 1) ≠ 0 := by positivity
        field_simp
      have hfrac : (s.card : ℝ) / ((s.card : ℝ) + 1) < 1 := by
        rw [div_lt_one (by positivity)]
        linarith
      have hlast : (s.card : ℝ) * (r / (2 * ((s.card : ℝ) + 1))) < r / 2 := by
        rw [heq]
        nlinarith [hr, hfrac]
      linarith
    have h1 : dist (∑ m ∈ s, lp.single 2 m ((f : ∀ m, S m) m)) f < r / 2 := hs
    have h2 : dist (∑ m ∈ s, lp.single 2 m (y m))
        (∑ m ∈ s, lp.single 2 m ((f : ∀ m, S m) m)) < r / 2 := by
      rw [dist_eq_norm, ← norm_neg]
      simpa using lt_of_le_of_lt hdiff hbound
    have htri := dist_triangle (∑ m ∈ s, lp.single 2 m (y m))
      (∑ m ∈ s, lp.single 2 m ((f : ∀ m, S m) m)) f
    simp only [Metric.mem_ball]
    linarith
  · -- and it lies in the finite-particle domain
    exact Submodule.sum_mem _ fun m _ => single_mem_fockCore m (y m) (hyD m)

/-! ## Second quantization of a sector-wise family of operators -/

/-- The sector-wise action of a family of sector operators on a finite-particle
state. -/
noncomputable def sectorApply (A : ∀ m, D m →ₗ[ℂ] D m) (f : fockCore D) : ∀ m, S m :=
  fun m => ((A m ⟨(f : lp S 2) m, (f.2).2 m⟩ : D m) : S m)

theorem sectorApply_support (A : ∀ m, D m →ₗ[ℂ] D m) (f : fockCore D) :
    (Function.support fun m => ‖sectorApply A f m‖).Finite := by
  refine ((f.2).1).subset ?_
  intro m hm
  simp only [Function.mem_support] at hm ⊢
  intro hzero
  apply hm
  have hz : ((⟨(f : lp S 2) m, (f.2).2 m⟩ : D m)) = 0 := by
    ext
    simpa using hzero
  simp [sectorApply, hz]

/-- **`dΓ` in sectors.**  The second quantization of a sector-wise family of
operators, acting on the finite-particle domain. -/
noncomputable def fockOp (A : ∀ m, D m →ₗ[ℂ] D m) : fockCore D →ₗ[ℂ] fockCore D where
  toFun f := ⟨ofSectors (sectorApply A f) (sectorApply_support A f), by
    constructor
    · exact sectorApply_support A f
    · intro m; exact (A m ⟨(f : lp S 2) m, (f.2).2 m⟩).2⟩
  map_add' f g := by
    apply Subtype.ext
    apply lp.ext
    funext m
    exact congrArg Subtype.val
      ((A m).map_add ⟨(f : lp S 2) m, (f.2).2 m⟩ ⟨(g : lp S 2) m, (g.2).2 m⟩)
  map_smul' c f := by
    apply Subtype.ext
    apply lp.ext
    funext m
    exact congrArg Subtype.val ((A m).map_smul c ⟨(f : lp S 2) m, (f.2).2 m⟩)

@[simp] theorem fockOp_apply (A : ∀ m, D m →ₗ[ℂ] D m) (f : fockCore D) (m : ι) :
    ((fockOp A f : lp S 2) : ∀ m, S m) m = ((A m ⟨(f : lp S 2) m, (f.2).2 m⟩ : D m) : S m) := rfl

/-- On a one-sector state the second quantization is the sector operator. -/
theorem fockOp_single [DecidableEq ι] (A : ∀ m, D m →ₗ[ℂ] D m) (m : ι) (x : D m) :
    (fockOp A ⟨lp.single 2 m (x : S m), single_mem_fockCore m (x : S m) x.2⟩ : lp S 2)
      = lp.single 2 m ((A m x : D m) : S m) := by
  set f : fockCore D := ⟨lp.single 2 m (x : S m), single_mem_fockCore m (x : S m) x.2⟩ with hf
  apply lp.ext
  funext j
  rw [fockOp_apply A f j]
  rcases eq_or_ne j m with rfl | hne
  · have hx : (⟨(f : lp S 2) j, (f.2).2 j⟩ : D j) = x := by
      ext
      change ((lp.single 2 j (x : S j) : lp S 2) : ∀ j, S j) j = (x : S j)
      exact lp.single_apply_self 2 j (x : S j)
    rw [hx, lp.single_apply_self]
  · have hz : (⟨(f : lp S 2) j, (f.2).2 j⟩ : D j) = 0 := by
      ext
      change ((lp.single 2 m (x : S m) : lp S 2) : ∀ j, S j) j = 0
      exact lp.single_apply_ne 2 m (x : S m) hne
    rw [hz, lp.single_apply_ne 2 m _ hne]
    simp

/-! ## Essential self-adjointness lifts from the sectors to the Fock space -/

/-- **Second quantization of essentially self-adjoint operators**
(Reed–Simon Vol. I, §VIII.10).  If every sector operator `A m` has vanishing
adjoint deficiency on its sector domain `D m`, then the second quantization
`fockOp A` has vanishing adjoint deficiency on the finite-particle domain
`𝓕_fin(D)` of the Fock space.

This is the statement that makes the Faris–Lavine "cage" structurally sound in
Fock space: the comparison operator `N̂ = dΓ(n) + I` is essentially self-adjoint
as soon as its one-particle constituent is, sector by sector. -/
theorem fockOp_hasZeroDeficiencyOn (A : ∀ m, D m →ₗ[ℂ] D m)
    (hA : ∀ m, HasZeroDeficiencyOn (D m) (A m)) :
    HasZeroDeficiencyOn (fockCore D) (fockOp A) := by
  classical
  have key : ∀ (z : ℂ) (w : lp S 2),
      (∀ v : fockCore D, (inner ℂ ((fockOp A v : lp S 2)) w : ℂ) = inner ℂ ((v : lp S 2)) (z • w)) →
      ∀ m : ι, ∀ x : D m,
        (inner ℂ ((A m x : D m) : S m) ((w : ∀ m, S m) m) : ℂ)
          = inner ℂ ((x : S m)) (z • (w : ∀ m, S m) m) := by
    intro z w hw m x
    have hv := hw ⟨lp.single 2 m (x : S m), single_mem_fockCore m (x : S m) x.2⟩
    rw [fockOp_single A m x] at hv
    rw [lp.inner_single_left] at hv
    have hz : ((z • w : lp S 2) : ∀ m, S m) m = z • (w : ∀ m, S m) m := by
      simp [lp.coeFn_smul]
    rw [show ((⟨lp.single 2 m (x : S m), single_mem_fockCore m (x : S m) x.2⟩ :
        fockCore D) : lp S 2) = lp.single 2 m (x : S m) from rfl, lp.inner_single_left,
      hz] at hv
    exact hv
  constructor
  · intro w hw
    apply lp.ext
    funext m
    have hm := (hA m).1 ((w : ∀ m, S m) m) (fun x => key Complex.I w hw m x)
    simpa using hm
  · intro w hw
    apply lp.ext
    funext m
    have hw' : ∀ v : fockCore D,
        (inner ℂ ((fockOp A v : lp S 2)) w : ℂ)
          = inner ℂ ((v : lp S 2)) ((-Complex.I) • w) := by
      intro v
      simpa using hw v
    have hm := (hA m).2 ((w : ∀ m, S m) m) (fun x => by
      simpa using key (-Complex.I) w hw' m x)
    simpa using hm

/-! ### The finite-particle domain is a *proper* subspace -/

/-- With infinitely many sectors each carrying a unit vector, the finite-particle
domain is a proper subspace of the Fock space: essential self-adjointness on it
is a genuine unbounded-operator statement, not a statement about the whole
space. -/
theorem fockCore_ne_top {S : ℕ → Type*} [∀ m, NormedAddCommGroup (S m)]
    [∀ m, InnerProductSpace ℂ (S m)] (D : ∀ m, Submodule ℂ (S m))
    (v : ∀ m, S m) (hv : ∀ m, ‖v m‖ = 1) :
    (fockCore D : Submodule ℂ (lp S 2)) ≠ ⊤ := by
  intro htop
  set g : ∀ m, S m := fun m => ((1 : ℝ) / (m + 1) : ℝ) • v m with hg
  have hnorm : ∀ k : ℕ, ‖g k‖ = 1 / (k + 1) := by
    intro k
    have hpos : (0 : ℝ) ≤ 1 / ((k : ℝ) + 1) := by positivity
    simp only [hg, norm_smul, hv, Real.norm_eq_abs, mul_one]
    exact abs_of_nonneg hpos
  have hmem : Memℓp g 2 := by
    apply memℓp_gen
    have hcongr : ∀ k : ℕ, ‖g k‖ ^ (2 : ℝ≥0∞).toReal = (1 / ((k : ℝ) + 1)) ^ 2 := by
      intro k
      rw [hnorm k]
      norm_num
    rw [summable_congr hcongr]
    have hbase : Summable fun k : ℕ => (1 / ((k : ℝ)) ^ 2) :=
      Real.summable_one_div_nat_pow.mpr (by norm_num : 1 < 2)
    have := (summable_nat_add_iff (f := fun k : ℕ => (1 / ((k : ℝ)) ^ 2)) 1).mpr hbase
    refine this.congr fun k => ?_
    rw [div_pow]
    norm_num
  have hmemCore : (⟨g, hmem⟩ : lp S 2) ∈ fockCore D := by rw [htop]; trivial
  have hfin := hmemCore.1
  have hinf : ¬ (Function.support fun m => ‖g m‖).Finite := by
    intro hfin'
    have hsub : Set.univ ⊆ Function.support fun m => ‖g m‖ := by
      intro k _
      simp only [Function.mem_support, hnorm k]
      positivity
    exact Set.infinite_univ (hfin'.subset hsub)
  exact hinf hfin

end SecondQuant

end BookProof.NavierStokesFlow
