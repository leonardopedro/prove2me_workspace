import Mathlib
import BookProof.ChapterNavierStokesLagrangianEsa

/-!
# The Fock space of a Fock space, and its ladder operators

The Lagrangian form of the Navier–Stokes Hamiltonian of
`BookProof.ChapterNavierStokesLagrangianEsa` is a *second* quantization: the
Eulerian field `u` is already an operator on a Fock space, and passing to the
parcel variables `X(ξ)` — one field-carrying parcel for each label `ξ` in a
continuous domain — quantizes the parcels themselves.  The state space is
therefore a Fock space **whose one-particle space is itself a Fock space**, and
the Hamiltonian is *quadratic* in the outer (parcel) creation and annihilation
operators.

This module builds that state space concretely, in the occupation-number
representation, together with both levels of ladder operators.

* `lpDiag`, `lpBasis` — a general diagonal operator with a real symbol on the
  finitely supported modes of `ℓ²(ι)`, its eigenbasis, symmetry, essential
  self-adjointness (`lpDiag_hasZeroDeficiencyOn`) and unboundedness
  (`lpDiag_not_bounded`).
* `Conf M = M →₀ ℕ`, `FockL2 M = ℓ²(Conf M)`, `FockDom M` — the Fock space over
  the mode index `M` in the occupation-number representation and its dense
  domain of finite-particle, finite-mode states.
* `annih m`, `creat m` — the annihilation and creation operators, with
  `annih_basis`, `creat_basis` (the usual `√n` factors), `creat_adjoint`
  (`⟪a†v, w⟫ = ⟪v, a w⟫`) and the canonical commutation relations
  `ccr_same`, `ccr_ne`.
* `numberOp m = a†ₘ aₘ` and `numberOp_basis` — the mode occupation operator.
* `FockOfFockL2 J K = FockL2 (J × Conf K)` — **the Fock space of a Fock space**:
  the outer one-particle modes are indexed by a parcel mode `j : J` *together
  with* an inner Fock (occupation) state `c : Conf K`.  `outerOneParticle` shows
  that the outer creation operator applied to the vacuum creates exactly one
  parcel carrying the inner Fock state `c`.

The Hamiltonian itself, its integral over the continuous parcel domain and its
essential self-adjointness are in `BookProof.ChapterNavierStokesFockEsa`.
-/

namespace BookProof.NavierStokesFlow

namespace FockOfFock

open FullEsa

/-! ## Finitely supported coefficient vectors in `ℓ²(ι)` -/

section Coeff

variable {ι : Type*}

/-- A finitely supported coefficient function is square-summable. -/
theorem memℓpTwo_of_finite_support {φ : ι → ℂ} (h : (Function.support φ).Finite) :
    Memℓp φ 2 := by
  apply memℓp_gen
  refine summable_of_finite_support (Set.Finite.subset h ?_)
  intro x hx
  simp only [Function.mem_support] at hx ⊢
  intro hz
  exact hx (by simp [hz])

/-- The finite-mode vector of `ℓ²(ι)` with the given finitely supported
coefficients. -/
def ofCoeff (φ : ι → ℂ) (h : (Function.support φ).Finite) : lpFiniteModes ι :=
  ⟨⟨φ, memℓpTwo_of_finite_support h⟩, h⟩

@[simp] theorem ofCoeff_coe (φ : ι → ℂ) (h : (Function.support φ).Finite) :
    (((ofCoeff φ h : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ) = φ := rfl

/-- A coefficientwise linear operator on the finite-mode domain of `ℓ²(ι)`. -/
def coeffOp (T : (ι → ℂ) → ι → ℂ)
    (hsupp : ∀ {φ : ι → ℂ}, (Function.support φ).Finite → (Function.support (T φ)).Finite)
    (hadd : ∀ φ ψ : ι → ℂ, T (φ + ψ) = T φ + T ψ)
    (hsmul : ∀ (c : ℂ) (φ : ι → ℂ), T (c • φ) = c • T φ) :
    lpFiniteModes ι →ₗ[ℂ] lpFiniteModes ι where
  toFun f := ofCoeff (T ((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ)) (hsupp f.2)
  map_add' f g := by
    ext i
    have : (((f + g : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ)
        = ((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) + ((g : lp (fun _ : ι => ℂ) 2) : ι → ℂ) := by
      ext j; simp
    simp [ofCoeff, hadd]
  map_smul' c f := by
    ext i
    have : (((c • f : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ)
        = c • ((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) := by
      ext j; simp
    simp [ofCoeff, hsmul]

@[simp] theorem coeffOp_coe (T : (ι → ℂ) → ι → ℂ) (hsupp) (hadd) (hsmul) (f : lpFiniteModes ι) :
    (((coeffOp T hsupp hadd hsmul f : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ)
      = T ((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) := rfl

/-- The canonical basis state `e_i` of the finite-mode domain. -/
noncomputable def lpBasis [DecidableEq ι] (i : ι) : lpFiniteModes ι :=
  ⟨lp.single 2 i 1, lpSingle_mem_lpFiniteModes i 1⟩

theorem lpBasis_coe [DecidableEq ι] (i j : ι) :
    (((lpBasis i : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ) j
      = if j = i then 1 else 0 := by
  by_cases h : j = i
  · subst h; simp [lpBasis, lp.single_apply]
  · simp [lpBasis, lp.single_apply, h]

theorem norm_lpBasis [DecidableEq ι] (i : ι) : ‖lpBasis (ι := ι) i‖ = 1 := by
  have : ‖((lpBasis i : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2)‖ = ‖(1 : ℂ)‖ :=
    lp.norm_single (by norm_num) i 1
  simpa using this

/-- The basis states are total: only `0` is orthogonal to all of them. -/
theorem lpBasis_total [DecidableEq ι] (w : lp (fun _ : ι => ℂ) 2)
    (hw : ∀ i, (inner ℂ ((lpBasis i : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) w : ℂ) = 0) :
    w = 0 := by
  ext i
  have h := hw i
  rw [show ((lpBasis i : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) = lp.single 2 i 1 from rfl,
    lp.inner_single_left] at h
  simpa using h

/-- **For an infinite mode index the finite-mode domain is a proper subspace**:
the `ℓ²` state supported on an infinite family of modes with coefficients
`1/(k+1)` has infinitely many excited modes.  So statements of essential
self-adjointness on this domain are genuine (non-`⊤`) ones. -/
theorem lpFiniteModes_ne_top (ι : Type*) [Infinite ι] :
    lpFiniteModes ι ≠ (⊤ : Submodule ℂ (lp (fun _ : ι => ℂ) 2)) := by
  classical
  set e : ℕ ↪ ι := Infinite.natEmbedding ι with he
  set φ : ι → ℂ := fun i => if h : ∃ k, e k = i then 1 / ((Classical.choose h : ℕ) + 1 : ℂ) else 0
    with hφ
  have hval : ∀ k : ℕ, φ (e k) = 1 / ((k : ℂ) + 1) := by
    intro k
    have hex : ∃ j, e j = e k := ⟨k, rfl⟩
    have hchoose : Classical.choose hex = k := e.injective (Classical.choose_spec hex)
    simp only [hφ, dif_pos hex, hchoose]
  have hout : ∀ i ∉ Set.range e, ‖φ i‖ ^ 2 = 0 := by
    intro i hi
    have : ¬ ∃ k, e k = i := fun ⟨k, hk⟩ => hi ⟨k, hk⟩
    simp [hφ, dif_neg this]
  have hsummable : Summable fun i => ‖φ i‖ ^ 2 := by
    refine (e.injective.summable_iff hout).1 ?_
    have hcomp : (fun k : ℕ => ‖φ (e k)‖ ^ 2) = fun k : ℕ => (1 / ((k : ℝ) + 1)) ^ 2 := by
      funext k
      have hcast : ((k : ℂ) + 1) = ((k + 1 : ℕ) : ℂ) := by push_cast; ring
      rw [hval k, hcast, norm_div, norm_one, Complex.norm_natCast]
      push_cast
      ring
    have hsum : Summable fun k : ℕ => (1 / ((k : ℝ) + 1)) ^ 2 := by
      have hbase := (Real.summable_one_div_nat_pow (p := 2)).mpr (by norm_num)
      refine ((summable_nat_add_iff 1).2 hbase).congr fun k => ?_
      push_cast
      rw [div_pow, one_pow]
    rw [Function.comp_def, hcomp]
    exact hsum
  have hmem : Memℓp φ 2 := by
    apply memℓp_gen
    simpa using hsummable
  intro htop
  have hg : (⟨φ, hmem⟩ : lp (fun _ : ι => ℂ) 2) ∈ lpFiniteModes ι := htop ▸ Submodule.mem_top
  rw [mem_lpFiniteModes] at hg
  have hsub : Set.range e ⊆ Function.support φ := by
    rintro _ ⟨k, rfl⟩
    have : φ (e k) ≠ 0 := by
      rw [hval k]
      refine one_div_ne_zero ?_
      have : ((k : ℂ) + 1) = ((k + 1 : ℕ) : ℂ) := by push_cast; ring
      rw [this]
      exact_mod_cast Nat.succ_ne_zero k
    simpa [Function.mem_support] using this
  exact (Set.infinite_range_of_injective e.injective) (hg.subset hsub)

end Coeff

/-! ## Diagonal operators with a real symbol -/

section Diagonal

variable {ι : Type*}

/-- Coefficientwise multiplication by a real symbol. -/
def diagCoeff (c : ι → ℝ) (φ : ι → ℂ) : ι → ℂ := fun i => (c i : ℂ) * φ i

/-- The diagonal operator with real symbol `c` on the finite-mode domain of
`ℓ²(ι)`.  For an unbounded symbol it is an unbounded operator. -/
noncomputable def lpDiag (c : ι → ℝ) : lpFiniteModes ι →ₗ[ℂ] lpFiniteModes ι :=
  coeffOp (diagCoeff c)
    (fun {φ} h => h.subset (by
      intro i hi
      simp only [Function.mem_support, diagCoeff] at hi ⊢
      intro hz
      exact hi (by simp [hz])))
    (fun φ ψ => by funext i; simp [diagCoeff]; ring)
    (fun a φ => by funext i; simp [diagCoeff]; ring)

@[simp] theorem lpDiag_coe (c : ι → ℝ) (f : lpFiniteModes ι) (i : ι) :
    (((lpDiag c f : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i
      = (c i : ℂ) * ((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i := rfl

theorem lpDiag_basis [DecidableEq ι] (c : ι → ℝ) (i : ι) :
    lpDiag c (lpBasis i) = ((c i : ℝ) : ℂ) • lpBasis i := by
  ext j
  by_cases h : j = i
  · subst h; simp [lpDiag_coe, lpBasis_coe]
  · simp [lpDiag_coe, lpBasis_coe, h]

theorem lpDiag_isSymmetricDom (c : ι → ℝ) : IsSymmetricDom (lpDiag c) := by
  intro x y
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun i => ?_
  simp only [RCLike.inner_apply, lpDiag_coe, map_mul, Complex.conj_ofReal]
  ring

/-- **A diagonal operator with an arbitrary real symbol is essentially
self-adjoint** on the finite-mode domain: its basis states are a total family of
eigenvectors with real eigenvalues.  No boundedness is required. -/
theorem lpDiag_hasZeroDeficiencyOn (c : ι → ℝ) :
    HasZeroDeficiencyOn (lpFiniteModes ι) (lpDiag c) := by
  classical
  exact hasZeroDeficiencyOn_of_total_eigenvectors _ _ lpBasis c (lpDiag_basis c) lpBasis_total

/-- The diagonal operator is genuinely unbounded when its symbol is. -/
theorem lpDiag_not_bounded (c : ι → ℝ) (hc : ∀ C : ℝ, ∃ i, C < |c i|) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes ι, ‖lpDiag c f‖ ≤ C * ‖f‖ := by
  classical
  rintro ⟨C, hC⟩
  obtain ⟨i, hi⟩ := hc C
  have hb := hC (lpBasis i)
  rw [lpDiag_basis, norm_smul, norm_lpBasis] at hb
  have hle : |c i| ≤ C := by simpa using hb
  exact absurd hi (not_lt.mpr hle)

end Diagonal

/-! ## The Fock space in the occupation-number representation -/

section Fock

variable {M : Type*} [DecidableEq M]

/-- An occupation-number configuration: finitely many modes excited, each
finitely often. -/
abbrev Conf (M : Type*) := M →₀ ℕ

/-- The bosonic Fock space over the mode index `M`, in the occupation-number
representation. -/
abbrev FockL2 (M : Type*) := lp (fun _ : Conf M => ℂ) 2

/-- The dense domain of finite-particle, finite-mode states. -/
abbrev FockDom (M : Type*) : Submodule ℂ (FockL2 M) := lpFiniteModes (Conf M)

omit [DecidableEq M] in
theorem fockDom_dense : Dense ((FockDom M : Submodule ℂ (FockL2 M)) : Set (FockL2 M)) :=
  lpFiniteModes_dense

omit [DecidableEq M] in
/-- The finite-particle domain of the Fock space is a **proper** dense subspace
as soon as there is at least one mode: essential self-adjointness on it is a
statement about a genuinely unbounded operator on a proper core, not the
trivial everywhere-defined case. -/
theorem fockDom_ne_top [Nonempty M] :
    (FockDom M : Submodule ℂ (FockL2 M)) ≠ ⊤ :=
  lpFiniteModes_ne_top (Conf M)

/-- The occupation-number basis state `|n⟩`. -/
noncomputable def fockBasis (n : Conf M) : FockDom M := lpBasis n

theorem fockBasis_coe (n k : Conf M) :
    (((fockBasis n : FockDom M) : FockL2 M) : Conf M → ℂ) k = if k = n then 1 else 0 :=
  lpBasis_coe n k

/-- The vacuum `|0⟩`. -/
noncomputable def vacuum : FockDom M := fockBasis 0

/-! ### Annihilation and creation -/

omit [DecidableEq M] in
/-- Adding and then removing one quantum in the mode `m` is the identity. -/
theorem add_single_sub_single (m : M) (n : Conf M) :
    (n + Finsupp.single m 1 : Conf M) - Finsupp.single m 1 = n := by
  ext j
  rcases eq_or_ne j m with rfl | hj
  · simp
  · simp

omit [DecidableEq M] in
/-- Removing and then adding one quantum in an occupied mode is the identity. -/
theorem sub_single_add_single {m : M} {n : Conf M} (h : 1 ≤ n m) :
    (n - Finsupp.single m 1 : Conf M) + Finsupp.single m 1 = n := by
  ext j
  rcases eq_or_ne j m with rfl | hj
  · simp; omega
  · simp [hj]

/-- Coefficient form of the annihilation operator `aₘ`. -/
noncomputable def annihCoeff (m : M) (φ : Conf M → ℂ) : Conf M → ℂ :=
  fun n => (Real.sqrt (n m + 1) : ℂ) * φ (n + Finsupp.single m 1)

/-- Coefficient form of the creation operator `a†ₘ`. -/
noncomputable def creatCoeff (m : M) (φ : Conf M → ℂ) : Conf M → ℂ :=
  fun n => (Real.sqrt (n m) : ℂ) * φ (n - Finsupp.single m 1)

omit [DecidableEq M] in
theorem annihCoeff_support {m : M} {φ : Conf M → ℂ} (h : (Function.support φ).Finite) :
    (Function.support (annihCoeff m φ)).Finite := by
  refine (h.image fun n => n - Finsupp.single m 1).subset ?_
  intro n hn
  simp only [Function.mem_support, annihCoeff] at hn
  refine ⟨n + Finsupp.single m 1, ?_, by simp⟩
  simp only [Function.mem_support]
  intro hz
  exact hn (by simp [hz])

omit [DecidableEq M] in
theorem creatCoeff_support {m : M} {φ : Conf M → ℂ} (h : (Function.support φ).Finite) :
    (Function.support (creatCoeff m φ)).Finite := by
  refine (h.image fun n => n + Finsupp.single m 1).subset ?_
  intro n hn
  simp only [Function.mem_support, creatCoeff] at hn
  have hpos : 1 ≤ n m := by
    by_contra hlt
    have : n m = 0 := by omega
    apply hn
    simp [this]
  refine ⟨n - Finsupp.single m 1, ?_, ?_⟩
  · simp only [Function.mem_support]
    intro hz
    exact hn (by simp [hz])
  · exact sub_single_add_single hpos

/-- **The annihilation operator** `aₘ` on the finite-particle domain. -/
noncomputable def annih (m : M) : FockDom M →ₗ[ℂ] FockDom M :=
  coeffOp (annihCoeff m) (fun {_} h => annihCoeff_support h)
    (fun φ ψ => by funext n; simp [annihCoeff]; ring)
    (fun a φ => by funext n; simp [annihCoeff]; ring)

/-- **The creation operator** `a†ₘ` on the finite-particle domain. -/
noncomputable def creat (m : M) : FockDom M →ₗ[ℂ] FockDom M :=
  coeffOp (creatCoeff m) (fun {_} h => creatCoeff_support h)
    (fun φ ψ => by funext n; simp [creatCoeff]; ring)
    (fun a φ => by funext n; simp [creatCoeff]; ring)

omit [DecidableEq M] in
@[simp] theorem annih_coe (m : M) (f : FockDom M) (n : Conf M) :
    (((annih m f : FockDom M) : FockL2 M) : Conf M → ℂ) n
      = (Real.sqrt (n m + 1) : ℂ) * ((f : FockL2 M) : Conf M → ℂ) (n + Finsupp.single m 1) := rfl

omit [DecidableEq M] in
@[simp] theorem creat_coe (m : M) (f : FockDom M) (n : Conf M) :
    (((creat m f : FockDom M) : FockL2 M) : Conf M → ℂ) n
      = (Real.sqrt (n m) : ℂ) * ((f : FockL2 M) : Conf M → ℂ) (n - Finsupp.single m 1) := rfl

/-- `aₘ |n⟩ = √(nₘ) |n − δₘ⟩`. -/
theorem annih_basis (m : M) (n : Conf M) :
    annih m (fockBasis n) = ((Real.sqrt (n m) : ℝ) : ℂ) • fockBasis (n - Finsupp.single m 1) := by
  ext k
  rcases eq_or_ne (k + Finsupp.single m 1) n with hk | hk
  · have hkm : k = n - Finsupp.single m 1 := by
      rw [← hk, add_single_sub_single]
    have hnm : (n m : ℝ) = (k m : ℝ) + 1 := by
      rw [← hk]; push_cast; simp
    subst hkm
    simp [annih_coe, fockBasis_coe, hk, hnm]
  · have hkne : k ≠ n - Finsupp.single m 1 ∨ (n m) = 0 := by
      by_contra hcon
      push_neg at hcon
      obtain ⟨hk1, hk2⟩ := hcon
      apply hk
      rw [hk1]
      exact sub_single_add_single (by omega)
    simp only [annih_coe, fockBasis_coe, hk, if_false, mul_zero, Submodule.coe_smul]
    rcases hkne with h | h
    · simp [fockBasis_coe, h]
    · simp [h]

/-- `a†ₘ |n⟩ = √(nₘ + 1) |n + δₘ⟩`. -/
theorem creat_basis (m : M) (n : Conf M) :
    creat m (fockBasis n)
      = ((Real.sqrt (n m + 1) : ℝ) : ℂ) • fockBasis (n + Finsupp.single m 1) := by
  ext k
  rcases eq_or_ne k (n + Finsupp.single m 1) with rfl | hk
  · have h1 : (n + Finsupp.single m 1 : Conf M) - Finsupp.single m 1 = n :=
      add_single_sub_single m n
    have h2 : ((n + Finsupp.single m 1 : Conf M) m : ℝ) = (n m : ℝ) + 1 := by push_cast; simp
    simp [creat_coe, fockBasis_coe, h1]
  · have hne : k - Finsupp.single m 1 ≠ n ∨ k m = 0 := by
      by_contra hcon
      push_neg at hcon
      obtain ⟨h1, h2⟩ := hcon
      apply hk
      rw [← h1]
      exact (sub_single_add_single (by omega)).symm
    simp only [creat_coe, fockBasis_coe, Submodule.coe_smul]
    have hr : (((fockBasis (n + Finsupp.single m 1) : FockDom M) : FockL2 M) : Conf M → ℂ) k = 0
        := by
      rw [fockBasis_coe, if_neg hk]
    rcases hne with h | h
    · rw [if_neg h, mul_zero]
      simp [hr]
    · rw [h]
      simp [hr]

/-- The outer creation operator applied to the vacuum creates the one-particle
state of the mode `m`. -/
theorem creat_vacuum (m : M) :
    creat m (vacuum : FockDom M) = fockBasis (Finsupp.single m 1) := by
  rw [vacuum, creat_basis]
  simp

theorem annih_vacuum (m : M) : annih m (vacuum : FockDom M) = 0 := by
  rw [vacuum, annih_basis]
  simp

/-! ### The canonical commutation relations -/

omit [DecidableEq M] in
/-- `[aₘ, a†ₘ] = 1`. -/
theorem ccr_same (m : M) :
    (annih m).comp (creat m) - (creat m).comp (annih m)
      = LinearMap.id (R := ℂ) (M := FockDom M) := by
  ext f n
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.id_apply,
    Submodule.coe_sub, Pi.sub_apply, annih_coe, creat_coe, lp.coeFn_sub]
  have h1 : ((n + Finsupp.single m 1 : Conf M) m : ℝ) = (n m : ℝ) + 1 := by push_cast; simp
  have h2 : (n + Finsupp.single m 1 : Conf M) - Finsupp.single m 1 = n :=
    add_single_sub_single m n
  rw [h1, h2]
  rcases Nat.eq_zero_or_pos (n m) with h | h
  · simp [h]
  · have h3 : ((n - Finsupp.single m 1 : Conf M) m : ℝ) + 1 = (n m : ℝ) := by
      have : (n - Finsupp.single m 1 : Conf M) m = n m - 1 := by simp
      rw [this]
      have : (1 : ℕ) ≤ n m := h
      push_cast [Nat.cast_sub this]
      ring
    have h4 : (n - Finsupp.single m 1 : Conf M) + Finsupp.single m 1 = n :=
      sub_single_add_single h
    rw [h3, h4]
    have hsq : (Real.sqrt ((n m : ℝ) + 1) : ℂ) * (Real.sqrt ((n m : ℝ) + 1) : ℂ)
        = ((n m : ℝ) + 1 : ℝ) := by
      rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity)]
    have hsq2 : (Real.sqrt (n m : ℝ) : ℂ) * (Real.sqrt (n m : ℝ) : ℂ) = ((n m : ℝ) : ℝ) := by
      rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity)]
    have hexp : ∀ z : ℂ, (Real.sqrt ((n m : ℝ) + 1) : ℂ) * ((Real.sqrt ((n m : ℝ) + 1) : ℂ) * z)
        - (Real.sqrt (n m : ℝ) : ℂ) * ((Real.sqrt (n m : ℝ) : ℂ) * z) = z := by
      intro z
      rw [← mul_assoc, ← mul_assoc, hsq, hsq2]
      push_cast
      ring
    exact hexp _

omit [DecidableEq M] in
/-- `[aₘ, a†ₘ'] = 0` for distinct modes. -/
theorem ccr_ne {m m' : M} (h : m ≠ m') :
    (annih m).comp (creat m') - (creat m').comp (annih m) = 0 := by
  ext f n
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.zero_apply,
    Submodule.coe_sub, Pi.sub_apply, annih_coe, creat_coe, lp.coeFn_sub, Submodule.coe_zero,
    lp.coeFn_zero, Pi.zero_apply]
  have hm' : ((n + Finsupp.single m 1 : Conf M) m' : ℝ) = (n m' : ℝ) := by
    simp [Ne.symm h]
  have hm : ((n - Finsupp.single m' 1 : Conf M) m : ℝ) + 1 = (n m : ℝ) + 1 := by
    simp [h]
  have harg : (n + Finsupp.single m 1 : Conf M) - Finsupp.single m' 1
      = (n - Finsupp.single m' 1 : Conf M) + Finsupp.single m 1 := by
    ext j
    rcases eq_or_ne j m with rfl | hj
    · simp [Ne.symm h]
    · rcases eq_or_ne j m' with rfl | hj'
      · simp [hj]
      · simp [Ne.symm hj, Ne.symm hj']
  rw [hm', hm, harg]
  ring

/-! ### Adjointness -/

/-- Every finite-mode vector is the finite sum of its basis components. -/
theorem lpFiniteModes_sum_repr {ι : Type*} [DecidableEq ι] (f : lpFiniteModes ι) :
    f = ∑ i ∈ f.2.toFinset, (((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i) • lpBasis i := by
  ext j
  have hcoe : (((∑ i ∈ f.2.toFinset, (((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i) • lpBasis i :
      lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ) j
      = ∑ i ∈ f.2.toFinset,
          (((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i) * (if j = i then 1 else 0) := by
    classical
    induction f.2.toFinset using Finset.induction with
    | empty => simp
    | insert a s ha ih =>
        rw [Finset.sum_insert ha, Finset.sum_insert ha]
        simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply, Submodule.coe_smul,
          lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, lpBasis_coe] at *
        rw [ih]
  rw [hcoe]
  by_cases hj : j ∈ f.2.toFinset
  · rw [Finset.sum_eq_single j]
    · simp
    · intro b _ hb; simp [Ne.symm hb]
    · intro hcon; exact absurd hj hcon
  · have hzero : ((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) j = 0 := by
      by_contra hne
      exact hj (by simpa [Set.Finite.mem_toFinset, Function.mem_support] using hne)
    rw [hzero]
    refine (Finset.sum_eq_zero fun i hi => ?_).symm
    by_cases hij : j = i
    · exact absurd (hij ▸ hi) hj
    · simp [hij]

omit [DecidableEq M] in
/-- **The creation operator is the adjoint of the annihilation operator** on the
finite-particle domain: `⟪a†ₘ v, w⟫ = ⟪v, aₘ w⟫`. -/
theorem creat_adjoint (m : M) (v w : FockDom M) :
    (inner ℂ ((creat m v : FockDom M) : FockL2 M) ((w : FockDom M) : FockL2 M) : ℂ)
      = inner ℂ ((v : FockDom M) : FockL2 M) ((annih m w : FockDom M) : FockL2 M) := by
  classical
  set V : Conf M → ℂ := ((v : FockL2 M) : Conf M → ℂ) with hV
  set W : Conf M → ℂ := ((w : FockL2 M) : Conf M → ℂ) with hW
  set F : Conf M → ℂ :=
    fun n => (Real.sqrt (n m) : ℂ) * (starRingEnd ℂ) (V (n - Finsupp.single m 1)) * W n with hF
  have hleft : (inner ℂ ((creat m v : FockDom M) : FockL2 M) ((w : FockDom M) : FockL2 M) : ℂ)
      = ∑' n : Conf M, F n := by
    rw [lp.inner_eq_tsum]
    refine tsum_congr fun n => ?_
    simp only [RCLike.inner_apply, creat_coe, hF, hV, hW, map_mul, Complex.conj_ofReal]
    ring
  have hright : (inner ℂ ((v : FockDom M) : FockL2 M) ((annih m w : FockDom M) : FockL2 M) : ℂ)
      = ∑' n : Conf M, F (n + Finsupp.single m 1) := by
    rw [lp.inner_eq_tsum]
    refine tsum_congr fun n => ?_
    have hm : ((n + Finsupp.single m 1 : Conf M) m : ℝ) = (n m : ℝ) + 1 := by push_cast; simp
    simp only [RCLike.inner_apply, annih_coe, hF, hV, hW, add_single_sub_single, hm]
    ring
  have hsupp : Function.support F ⊆ Set.range fun n : Conf M => n + Finsupp.single m 1 := by
    intro n hn
    simp only [Function.mem_support, hF] at hn
    have hpos : 1 ≤ n m := by
      by_contra hlt
      have hz : n m = 0 := by omega
      exact hn (by simp [hz])
    exact ⟨n - Finsupp.single m 1, sub_single_add_single hpos⟩
  rw [hleft, hright, (add_left_injective (Finsupp.single m 1)).tsum_eq hsupp]

end Fock

/-! ## The Fock space of a Fock space -/

section FockOfFockSpace

variable {J K : Type*} [DecidableEq J] [DecidableEq K]

/-- **The Fock space of a Fock space.**  The inner level is the Fock space
`FockL2 K` of the field modes `K`; a one-particle state of the *outer* level is
a parcel carrying a parcel mode `j : J` together with an inner Fock (occupation)
state `c : Conf K`, so the outer mode index is `J × Conf K`. -/
abbrev FockOfFockL2 (J K : Type*) := FockL2 (J × Conf K)

/-- The dense finite-particle domain of the two-level Fock space. -/
abbrev FockOfFockDom (J K : Type*) : Submodule ℂ (FockOfFockL2 J K) := FockDom (J × Conf K)

/-- The one-particle state of the outer Fock space carrying the inner Fock basis
state `c` in the parcel mode `j`: it is created from the outer vacuum by the
outer creation operator of the mode `(j, c)`. -/
theorem outerOneParticle (j : J) (c : Conf K) :
    creat (j, c) (vacuum : FockOfFockDom J K) = fockBasis (Finsupp.single (j, c) 1) :=
  creat_vacuum _

/-- The inner Fock basis states are total in the inner Fock space: the outer
one-particle modes really do range over a basis of a Fock space. -/
theorem innerBasis_total (w : FockL2 K)
    (hw : ∀ c : Conf K, (inner ℂ ((fockBasis c : FockDom K) : FockL2 K) w : ℂ) = 0) : w = 0 :=
  lpBasis_total w hw

end FockOfFockSpace

end FockOfFock

end BookProof.NavierStokesFlow
