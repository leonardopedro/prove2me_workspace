import Mathlib
import BookProof.ChapterNavierStokesHermiteFarisLavine

/-!
# The **bilinear** (quadratic-symbol) Navier–Stokes generator is essentially
self-adjoint

`BookProof.ChapterNavierStokesHermiteFarisLavine` proves the two Faris–Lavine
inequalities, and hence essential self-adjointness, for the Navier–Stokes fiber
Hamiltonian `H = ½(π V + V π)` with a **linear** advection field `V(u) = κ u`
and a *fixed* strain rate `κ`.  The residual recorded in the plan
(`CONSOLIDATED_PLAN.md` §9, "what is missing from the NS-FLOW plan") is the same
statement for the genuinely **quadratic** Navier–Stokes symbol

`A_i = ∑_j u_j u_{i,j} − ν u_{i,jj}`,

in the *Eulerian derivatives-as-fields* picture.  This module closes that
residual for the bilinear advection term, in the following precise sense.

## Why the quadratic symbol is a direct sum of linear ones

In the derivatives-as-fields construction the derivative modes `u_{i,j}` are
**independent field coordinates**, and — this is the structural point — the
Hamiltonian of the book carries momenta only for the velocity modes,
`H = ∑_i (π_i A_i + A_i π_i)` with `π_i = −i ∂/∂u_i`.  The derivative field is
therefore a *constant of the motion*: it commutes with `H`.  Diagonalising it,
the Hilbert space splits as `ℓ²(ℕ) ⊗ ℓ²(J) = ℓ²(ℕ × J)` — the Hermite levels of
the velocity fiber times the (joint) spectrum `J` of the derivative field — and
in the block `j` the bilinear symbol `A = u_{,1} · u` becomes the **linear**
field `V(u) = κ_j u`, with `κ_j` the eigenvalue of the derivative field.  The
strain rate is no longer a constant: it ranges over `J` and is in general
**unbounded**, which is exactly why no single pair of Faris–Lavine constants can
serve, and why the block decomposition, not a global Faris–Lavine estimate, is
the right instrument.

## What is proved

* `bilH` — the bilinear Navier–Stokes Hamiltonian on `ℓ²(ℕ × J)`, on the
  finite-mode core, for an **arbitrary** family of non-negative strain rates
  `κ : J → ℝ` (no boundedness, no finiteness of `J`);
* `bilFun_embFun` and `blockVec_bilH_apply` — the block identification: on the
  block `j` the operator *is* the fiber Hamiltonian `nsH (κ j)` of
  `ChapterNavierStokesHermiteFarisLavine`;
* `hasSum_inner_blocks` — the inner product of `ℓ²(ℕ × J)` is the sum of the
  fiber inner products over the blocks;
* `bilH_symmetricOn` — the Hamiltonian is symmetric on the finite-mode core;
* `deficiencyTrivialAt_bilH` — the block reduction of the deficiency problem: a
  deficiency vector of the whole operator restricts to a deficiency vector of
  each block;
* `bilH_essentiallySelfAdjointOn_core` — **the headline**: the bilinear
  Navier–Stokes Hamiltonian is essentially self-adjoint on the finite-mode core,
  for every family of strain rates, bounded or not;
* `bilH_not_bounded` — and it is genuinely unbounded as soon as the strain rates
  are, so the conclusion is not a boundedness phenomenon.

## Honest boundary

Everything below is stated on the abstract space `ℓ²(ℕ × J)`, with the block
operator given by its matrix in the Hermite basis of the fiber; the concrete
differential realization on `L²(du)` is not built here, exactly as in
`ChapterNavierStokesHermiteFarisLavine`.  The blocks handled are the ones whose
fiber field is `V(u) = κ_j u`.  The viscous term `−ν u_{i,jj}` and the cross
terms `u_j u_{i,j}` with `j ≠ i` add a *constant* (in `u_i`) to the fiber field,
making it affine, `V(u) = κ_j u + c_j`.  Covering that needs a `±1`-shift on top
of the `±2`-shift, and it is done in
`BookProof.ChapterNavierStokesAffineFiberEsa` (one fiber) and
`BookProof.ChapterNavierStokesAffineBlockEsa` (the block decomposition again,
with the affine fiber Hamiltonian in place of the linear one), for `c_j ≥ 0`.
Only one velocity component is carried: the three coupled components of the full
symbol are not.  Nothing here claims global regularity for the classical
Navier–Stokes equation, which remains the recorded scope cut.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace BilinearEsa

open LpNat FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}

/-! ## Blocks of `ℓ²(ℕ × J)` -/

/-- The `j`-th block of a state of `ℓ²(ℕ × J)`: the velocity-fiber state
obtained by freezing the derivative field at its eigenvalue `κ j`. -/
noncomputable def blockVec (w : L2I (ℕ × J)) (j : J) : L2I ℕ :=
  ⟨fun n => (w : ℕ × J → ℂ) (n, j), by
    refine memLpTwo_of_summable_normSq ?_
    have hs : Summable fun k : ℕ × J => ‖(w : ℕ × J → ℂ) k‖ ^ 2 := summable_normSq w
    have hinj : Function.Injective fun n : ℕ => (n, j) := by
      intro a b hab
      simpa using hab
    exact hs.comp_injective hinj⟩

@[simp] theorem blockVec_coe (w : L2I (ℕ × J)) (j : J) (n : ℕ) :
    ((blockVec w j : L2I ℕ) : ℕ → ℂ) n = (w : ℕ × J → ℂ) (n, j) := rfl

open scoped Classical in
/-- The coordinates of the embedding of a velocity-fiber state into the block
`j`. -/
noncomputable def embFun (j : J) (a : ℕ → ℂ) : ℕ × J → ℂ :=
  fun p => if p.2 = j then a p.1 else 0

@[simp] theorem embFun_self (j : J) (a : ℕ → ℂ) (n : ℕ) : embFun j a (n, j) = a n := by
  simp [embFun]

theorem embFun_of_ne {j j' : J} (a : ℕ → ℂ) (n : ℕ) (h : j' ≠ j) : embFun j a (n, j') = 0 := by
  simp [embFun, h]

theorem support_embFun (j : J) (a : ℕ → ℂ) :
    Function.support (embFun j a) ⊆ (fun n : ℕ => (n, j)) '' Function.support a := by
  rintro ⟨n, j'⟩ hp
  simp only [Function.mem_support, embFun] at hp
  by_cases hj : j' = j
  · subst hj
    simp only at hp
    exact ⟨n, hp, rfl⟩
  · simp [hj] at hp

theorem embFun_finite_support (j : J) (u : lpFiniteModes ℕ) :
    (Function.support (embFun j (((u : L2I ℕ)) : ℕ → ℂ))).Finite :=
  Set.Finite.subset (Set.Finite.image _ (mem_lpFiniteModes.mp u.2)) (support_embFun _ _)

/-- The embedding of a finite-mode velocity state as the `j`-th block. -/
noncomputable def blockEmb (j : J) (u : lpFiniteModes ℕ) : lpFiniteModes (ℕ × J) :=
  ⟨⟨embFun j (((u : L2I ℕ)) : ℕ → ℂ), memLpTwo_of_finite_support (embFun_finite_support j u)⟩,
    embFun_finite_support j u⟩

@[simp] theorem blockEmb_coe (j : J) (u : lpFiniteModes ℕ) (p : ℕ × J) :
    (((blockEmb j u : lpFiniteModes (ℕ × J)) : L2I (ℕ × J)) : ℕ × J → ℂ) p
      = embFun j (((u : L2I ℕ)) : ℕ → ℂ) p := rfl

/-- **The inner product of a block-supported state with an arbitrary state is
the fiber inner product with the corresponding block.** -/
theorem inner_of_block_supported (j : J) (x : L2I (ℕ × J)) (a : L2I ℕ)
    (hx : ∀ p, (x : ℕ × J → ℂ) p = embFun j ((a : ℕ → ℂ)) p) (w : L2I (ℕ × J)) :
    (inner ℂ x w : ℂ) = inner ℂ a (blockVec w j) := by
  have hinj : Function.Injective fun n : ℕ => (n, j) := by
    intro p q hpq
    simpa using hpq
  have h1 : HasSum (fun p : ℕ × J =>
      (inner ℂ ((x : ℕ × J → ℂ) p) ((w : ℕ × J → ℂ) p) : ℂ)) (inner ℂ x w) :=
    lp.hasSum_inner x w
  have hzero : ∀ p ∉ Set.range fun n : ℕ => (n, j),
      (inner ℂ ((x : ℕ × J → ℂ) p) ((w : ℕ × J → ℂ) p) : ℂ) = 0 := by
    rintro ⟨n, j'⟩ hp
    have hj : j' ≠ j := by
      intro h
      exact hp ⟨n, by simp [h]⟩
    rw [hx (n, j'), embFun_of_ne _ _ hj]
    simp
  have h1' := (hinj.hasSum_iff hzero).2 h1
  have hfun : ((fun p : ℕ × J => (inner ℂ ((x : ℕ × J → ℂ) p) ((w : ℕ × J → ℂ) p) : ℂ))
      ∘ fun n : ℕ => (n, j))
      = fun n : ℕ => (inner ℂ ((a : ℕ → ℂ) n) (((blockVec w j : L2I ℕ) : ℕ → ℂ) n) : ℂ) := by
    funext n
    simp [hx (n, j)]
  rw [hfun] at h1'
  exact h1'.unique (lp.hasSum_inner a (blockVec w j))

/-! ## The bilinear Navier–Stokes Hamiltonian -/

/-- The coordinates of the bilinear Navier–Stokes Hamiltonian: in the block `j`
it is the `±2`-shift `hFun (κ j)` of the Hermite representation. -/
noncomputable def bilFun (κ : J → ℝ) (X : ℕ × J → ℂ) : ℕ × J → ℂ :=
  fun p => hFun (κ p.2) (fun n => X (n, p.2)) p.1

theorem support_bilFun (κ : J → ℝ) (X : ℕ × J → ℂ) :
    Function.support (bilFun κ X) ⊆
      (fun p : ℕ × J => (p.1 + 2, p.2)) '' Function.support X ∪
      (fun p : ℕ × J => (p.1 - 2, p.2)) '' Function.support X := by
  rintro ⟨m, j⟩ hp
  simp only [Function.mem_support, bilFun, hFun] at hp
  by_cases h2 : X (m + 2, j) = 0
  · left
    have hs : shift2 (fun n => ((amp (κ j) n : ℂ)) * X (n, j)) m ≠ 0 := by
      intro h
      apply hp
      rw [h, h2]
      ring
    have hm : 2 ≤ m := by
      by_contra hcon
      exact hs (by simp [shift2, hcon])
    have hs' : ((amp (κ j) (m - 2) : ℂ)) * X (m - 2, j) ≠ 0 := by
      simpa [shift2, hm] using hs
    refine ⟨(m - 2, j), ?_, ?_⟩
    · simp only [Function.mem_support]
      intro h
      exact hs' (by rw [h]; ring)
    · simp only [Prod.mk.injEq, and_true]
      omega
  · right
    exact ⟨(m + 2, j), h2, by simp⟩

theorem bilFun_finite_support (κ : J → ℝ) (x : lpFiniteModes (ℕ × J)) :
    (Function.support (bilFun κ (((x : L2I (ℕ × J))) : ℕ × J → ℂ))).Finite := by
  have hx := mem_lpFiniteModes.mp x.2
  exact Set.Finite.subset ((hx.image _).union (hx.image _)) (support_bilFun _ _)

/-- **The bilinear Navier–Stokes Hamiltonian** on the finite-mode core of
`ℓ²(ℕ × J)`: `H = ½(π A + A π)` with the bilinear symbol `A = u_{,1} · u`, the
derivative field diagonalised with (arbitrary, possibly unbounded) eigenvalues
`κ : J → ℝ`. -/
noncomputable def bilH (κ : J → ℝ) : lpFiniteModes (ℕ × J) →ₗ[ℂ] L2I (ℕ × J) where
  toFun x := ⟨bilFun κ (((x : L2I (ℕ × J))) : ℕ × J → ℂ),
    memLpTwo_of_finite_support (bilFun_finite_support κ x)⟩
  map_add' x y := by
    refine lp.ext (funext fun p => ?_)
    simp only [lp.coeFn_add, Pi.add_apply, Submodule.coe_add, bilFun, hFun, shift2]
    by_cases h : 2 ≤ p.1 <;> simp [h] <;> ring
  map_smul' a x := by
    refine lp.ext (funext fun p => ?_)
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply, Submodule.coe_smul,
      bilFun, hFun, shift2]
    by_cases h : 2 ≤ p.1 <;> simp [h] <;> ring

@[simp] theorem bilH_coe (κ : J → ℝ) (x : lpFiniteModes (ℕ × J)) (p : ℕ × J) :
    ((bilH κ x : L2I (ℕ × J)) : ℕ × J → ℂ) p
      = bilFun κ (((x : L2I (ℕ × J))) : ℕ × J → ℂ) p := rfl

/-- **The block identification**: on the block `j` the bilinear Hamiltonian acts
as the Hermite fiber Hamiltonian with strain rate `κ j`. -/
theorem blockVec_bilH_apply (κ : J → ℝ) (x : lpFiniteModes (ℕ × J)) (j : J) (n : ℕ) :
    ((bilH κ x : L2I (ℕ × J)) : ℕ × J → ℂ) (n, j)
      = hFun (κ j) (fun m => ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j)) n := rfl

/-- The Hamiltonian preserves the blocks: it maps the `j`-th block onto itself,
acting there by the fiber Hamiltonian. -/
theorem bilFun_embFun (κ : J → ℝ) (j : J) (a : ℕ → ℂ) :
    bilFun κ (embFun j a) = embFun j (hFun (κ j) a) := by
  funext p
  obtain ⟨m, j'⟩ := p
  by_cases hj : j' = j
  · subst hj
    simp [bilFun, embFun]
  · simp only [bilFun, embFun, hFun, shift2, hj, if_false]
    simp

/-! ## Symmetry -/

/-- The inner product of `ℓ²(ℕ × J)` is the sum over the blocks of the fiber
inner products. -/
theorem hasSum_inner_blocks (x y : L2I (ℕ × J)) :
    HasSum (fun j : J => (inner ℂ (blockVec x j) (blockVec y j) : ℂ)) (inner ℂ x y) := by
  have h1 : HasSum (fun p : ℕ × J =>
      (inner ℂ ((x : ℕ × J → ℂ) p) ((y : ℕ × J → ℂ) p) : ℂ)) (inner ℂ x y) :=
    lp.hasSum_inner x y
  have h2 : HasSum (fun q : J × ℕ =>
      (inner ℂ ((x : ℕ × J → ℂ) (q.2, q.1)) ((y : ℕ × J → ℂ) (q.2, q.1)) : ℂ))
      (inner ℂ x y) := by
    have hiff := (Equiv.prodComm J ℕ).hasSum_iff
      (f := fun p : ℕ × J => (inner ℂ ((x : ℕ × J → ℂ) p) ((y : ℕ × J → ℂ) p) : ℂ))
      (a := (inner ℂ x y : ℂ))
    exact hiff.2 h1
  refine h2.prod_fiberwise ?_
  intro j
  exact lp.hasSum_inner (blockVec x j) (blockVec y j)

/-- Each block of a finite-mode state lies in the maximal domain of the fiber
comparison operator. -/
theorem blockVec_mem_maxDom (κ : J → ℝ) (v : lpFiniteModes (ℕ × J)) (j : J) :
    (blockVec ((v : L2I (ℕ × J))) j) ∈ maxDom (oscSymbol (κ j)) := by
  refine finiteModes_le_maxDom _ (mem_lpFiniteModes.mpr ?_)
  have hv := mem_lpFiniteModes.mp v.2
  have hinj : Function.Injective fun n : ℕ => (n, j) := by
    intro a b hab
    simpa using hab
  have hsub : Function.support
        (fun n : ℕ => (((blockVec ((v : L2I (ℕ × J))) j) : L2I ℕ) : ℕ → ℂ) n)
      ⊆ (fun n : ℕ => (n, j)) ⁻¹' Function.support (((v : L2I (ℕ × J))) : ℕ × J → ℂ) :=
    fun n hn => hn
  exact Set.Finite.subset (Set.Finite.preimage hinj.injOn hv) hsub

/-- The block of the image is the fiber Hamiltonian applied to the block. -/
theorem blockVec_bilH (κ : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (v : lpFiniteModes (ℕ × J)) (j : J) :
    blockVec ((bilH κ v : L2I (ℕ × J))) j
      = nsH (κ j) (hκ j) ⟨blockVec ((v : L2I (ℕ × J))) j, blockVec_mem_maxDom κ v j⟩ :=
  lp.ext (funext fun _ => rfl)

/-- **The bilinear Navier–Stokes Hamiltonian is symmetric** on the finite-mode
core. -/
theorem bilH_symmetricOn (κ : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) :
    SymmetricOn (lpFiniteModes (ℕ × J)) (bilH κ) := by
  intro x y
  have h1 := hasSum_inner_blocks ((bilH κ x : L2I (ℕ × J))) ((y : L2I (ℕ × J)))
  have h2 := hasSum_inner_blocks ((x : L2I (ℕ × J))) ((bilH κ y : L2I (ℕ × J)))
  have heq : ∀ j : J,
      (inner ℂ (blockVec ((bilH κ x : L2I (ℕ × J))) j) (blockVec ((y : L2I (ℕ × J))) j) : ℂ)
        = inner ℂ (blockVec ((x : L2I (ℕ × J))) j)
            (blockVec ((bilH κ y : L2I (ℕ × J))) j) := by
    intro j
    rw [blockVec_bilH κ hκ x j, blockVec_bilH κ hκ y j]
    exact nsH_symmetricOn (hκ j) ⟨_, blockVec_mem_maxDom κ x j⟩ ⟨_, blockVec_mem_maxDom κ y j⟩
  simp only [heq] at h1
  exact h1.unique h2

/-! ## Essential self-adjointness -/

/-- **Block reduction of the deficiency problem.**  A deficiency vector of the
bilinear Hamiltonian restricts, on each block, to a deficiency vector of the
fiber Hamiltonian; so triviality of the fiber deficiency spaces gives triviality
of the global one. -/
theorem deficiencyTrivialAt_bilH (κ : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (z : ℂ)
    (hblk : ∀ j, DeficiencyTrivialAt (lpFiniteModes ℕ)
      ((nsH (κ j) (hκ j)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (κ j))))) z) :
    DeficiencyTrivialAt (lpFiniteModes (ℕ × J)) (bilH κ) z := by
  intro w hw
  have hb : ∀ j, blockVec w j = 0 := by
    intro j
    refine hblk j (blockVec w j) ?_
    intro u
    have hv := hw (blockEmb j u)
    have hHcoe : ∀ p : ℕ × J,
        ((bilH κ (blockEmb j u) : L2I (ℕ × J)) : ℕ × J → ℂ) p
          = embFun j (((((nsH (κ j) (hκ j))
              (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (κ j))) u) :
                L2I ℕ)) : ℕ → ℂ)) p := by
      intro p
      have hb0 : ((bilH κ (blockEmb j u) : L2I (ℕ × J)) : ℕ × J → ℂ)
          = bilFun κ (embFun j (((u : L2I ℕ)) : ℕ → ℂ)) := rfl
      rw [hb0, bilFun_embFun]
      rfl
    have h1 := inner_of_block_supported j ((bilH κ (blockEmb j u) : L2I (ℕ × J)))
      (((nsH (κ j) (hκ j))
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (κ j))) u) : L2I ℕ)) hHcoe w
    have h2 := inner_of_block_supported j
      (((blockEmb j u : lpFiniteModes (ℕ × J)) : L2I (ℕ × J))) ((u : L2I ℕ))
      (fun _ => rfl) w
    rw [h1, h2] at hv
    exact hv
  refine lp.ext (funext fun p => ?_)
  obtain ⟨n, j⟩ := p
  have hz := congrArg (fun v : L2I ℕ => ((v : ℕ → ℂ)) n) (hb j)
  simpa using hz

/-- **The headline.**  The bilinear (quadratic-symbol) Navier–Stokes Hamiltonian
is essentially self-adjoint on the finite-mode core of `ℓ²(ℕ × J)`, for an
arbitrary — in particular unbounded — family of strain rates. -/
theorem bilH_essentiallySelfAdjointOn_core (κ : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) :
    EssentiallySelfAdjointOn (lpFiniteModes (ℕ × J)) (bilH κ) :=
  ⟨deficiencyTrivialAt_bilH κ hκ Complex.I
      fun j => (nsH_essentiallySelfAdjointOn_core (hκ j)).1,
   deficiencyTrivialAt_bilH κ hκ (-Complex.I)
      fun j => (nsH_essentiallySelfAdjointOn_core (hκ j)).2⟩

/-- The Hamiltonian is not the zero operator as soon as one strain rate is
positive: the essential self-adjointness above is not vacuous. -/
theorem bilH_ne_zero (κ : J → ℝ) {j : J} (hj : 0 < κ j) :
    ∃ x : lpFiniteModes (ℕ × J), bilH κ x ≠ 0 := by
  classical
  refine ⟨⟨lp.single 2 ((0 : ℕ), j) (1 : ℂ), lpSingle_mem_lpFiniteModes _ _⟩, ?_⟩
  set x : lpFiniteModes (ℕ × J) :=
    ⟨lp.single 2 ((0 : ℕ), j) (1 : ℂ), lpSingle_mem_lpFiniteModes _ _⟩ with hxdef
  have hX : ∀ n : ℕ, ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (n, j) = if n = 0 then 1 else 0 := by
    intro n
    simp [hxdef, lp.single_apply, Pi.single_apply, Prod.ext_iff]
  have hcoord : ((bilH κ x : L2I (ℕ × J)) : ℕ × J → ℂ) (2, j)
      = Complex.I * ((amp (κ j) 0 : ℝ) : ℂ) := by
    rw [blockVec_bilH_apply]
    simp [hFun, shift2, hX]
  have hamp : amp (κ j) 0 ≠ 0 := by
    have hs : 0 < Real.sqrt (((0 : ℕ) + 1) * ((0 : ℕ) + 2)) := by
      rw [Real.sqrt_pos]
      norm_num
    simp only [amp]
    positivity
  intro h0
  rw [h0] at hcoord
  simp only [lp.coeFn_zero, Pi.zero_apply] at hcoord
  have : ((amp (κ j) 0 : ℝ) : ℂ) = 0 := by
    have := hcoord.symm
    field_simp at this
    simpa using this
  exact hamp (by exact_mod_cast this)

/-- The finite-mode core is dense, so the Hamiltonian above is a densely defined
operator and its essential self-adjointness is the statement it should be. -/
theorem bilH_domain_dense :
    Dense ((lpFiniteModes (ℕ × J) : Submodule ℂ (L2I (ℕ × J))) : Set (L2I (ℕ × J))) :=
  lpFiniteModes_dense

/-! ## The operator is genuinely unbounded -/

/-- If the strain rates are unbounded, so is the bilinear Hamiltonian: essential
self-adjointness above is not a boundedness phenomenon. -/
theorem bilH_not_bounded (κ : J → ℝ) (hunb : ∀ C : ℝ, ∃ j, C < κ j) (C : ℝ) :
    ∃ x : lpFiniteModes (ℕ × J),
      ‖((x : lpFiniteModes (ℕ × J)) : L2I (ℕ × J))‖ = 1 ∧ C < ‖bilH κ x‖ := by
  classical
  obtain ⟨j, hj⟩ := hunb (2 * |C| + 2)
  have hκj : 0 ≤ κ j := by
    have : (0 : ℝ) ≤ 2 * |C| + 2 := by positivity
    linarith
  refine ⟨⟨lp.single 2 ((0 : ℕ), j) (1 : ℂ), lpSingle_mem_lpFiniteModes _ _⟩, ?_, ?_⟩
  · simp
  · set x : lpFiniteModes (ℕ × J) :=
      ⟨lp.single 2 ((0 : ℕ), j) (1 : ℂ), lpSingle_mem_lpFiniteModes _ _⟩ with hxdef
    have hX : ∀ n : ℕ, ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (n, j) = if n = 0 then 1 else 0 := by
      intro n
      simp [hxdef, lp.single_apply, Pi.single_apply, Prod.ext_iff]
    have hcoord : ((bilH κ x : L2I (ℕ × J)) : ℕ × J → ℂ) (2, j)
        = Complex.I * ((amp (κ j) 0 : ℝ) : ℂ) := by
      rw [blockVec_bilH_apply]
      simp [hFun, shift2, hX]
    have hb : ‖((bilH κ x : L2I (ℕ × J)) : ℕ × J → ℂ) (2, j)‖ ≤ ‖(bilH κ x : L2I (ℕ × J))‖ :=
      lp.norm_apply_le_norm (by norm_num) _ _
    rw [hcoord] at hb
    have hnv : ‖Complex.I * ((amp (κ j) 0 : ℝ) : ℂ)‖ = amp (κ j) 0 := by
      rw [norm_mul, Complex.norm_I, one_mul, Complex.norm_real, Real.norm_eq_abs,
        abs_of_nonneg (amp_nonneg hκj 0)]
    rw [hnv] at hb
    have hs : (1 : ℝ) ≤ Real.sqrt (((0 : ℕ) + 1) * ((0 : ℕ) + 2)) := by
      have h2 : (((0 : ℕ) : ℝ) + 1) * (((0 : ℕ) : ℝ) + 2) = 2 := by norm_num
      rw [show ((((0 : ℕ) : ℝ) + 1) * (((0 : ℕ) : ℝ) + 2)) = 2 from h2]
      nlinarith [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2), Real.sqrt_nonneg 2]
    have hamp : κ j / 2 ≤ amp (κ j) 0 := by
      have := mul_le_mul_of_nonneg_left hs (by linarith : (0 : ℝ) ≤ κ j / 2)
      simpa [amp] using this
    have hC : C ≤ |C| := le_abs_self C
    linarith

end BilinearEsa

end BookProof.NavierStokesFlow
