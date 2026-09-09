import Mathlib
import BookProof.ChapterNavierStokesBilinearEsa
import BookProof.ChapterNavierStokesAffineFiberEsa

/-!
# The bilinear Navier–Stokes generator **with the viscous and cross terms**

`BookProof.ChapterNavierStokesBilinearEsa` proves essential self-adjointness of
the bilinear (quadratic-symbol) Navier–Stokes generator on `ℓ²(ℕ × J)` by
splitting it into blocks indexed by the spectrum `J` of the derivative field: in
the block `j` the symbol becomes the *linear* fiber field `V(u) = κ_j u`.  Its
recorded boundary was the *affine* fiber field

`V(u) = κ_j u + c_j`,

which is what the viscous term `−ν u_{i,jj}` and the cross terms `u_j u_{i,j}`
with `j ≠ i` contribute: those are constants in the velocity mode `u_i` that the
momentum `π_i` differentiates, and — like the strain rates — they are functions
of the derivative field, hence constant on each block.

`BookProof.ChapterNavierStokesAffineFiberEsa` removes that boundary at the level
of one fiber.  This module runs the block decomposition again with the affine
fiber Hamiltonian in place of the linear one, and so covers the viscous and
cross terms.

## What is proved

* `affBlockH` — the Navier–Stokes generator on the finite-mode core of
  `ℓ²(ℕ × J)` whose block `j` is the **affine** fiber Hamiltonian
  `½(π V + V π)` with `V(u) = κ_j u + c_j`, for arbitrary families
  `κ, c : J → ℝ` of non-negative strain rates and constants (no boundedness, no
  finiteness of `J`);
* `affFun_embFun` and `blockVec_affBlockH` — the block identification: on the
  block `j` the operator *is* `AffineFiber.affH (κ j) (c j)`;
* `affBlockH_symmetricOn` — it is symmetric on the finite-mode core;
* `deficiencyTrivialAt_affBlockH` — the block reduction of the deficiency
  problem;
* `affBlockH_essentiallySelfAdjointOn_core` — **the headline**: it is
  essentially self-adjoint on the finite-mode core;
* `affBlockH_not_bounded` — and it is genuinely unbounded as soon as the strain
  rates are.

## Honest boundary

`c_j ≥ 0` is assumed, for the reason recorded in
`ChapterNavierStokesAffineFiberEsa` (a `ShiftData` amplitude must be
non-negative); the sign-flip unitary that would remove it is not formalized.
Only one velocity component is carried: the three coupled components of the full
symbol are not.  Everything is stated on the abstract space `ℓ²(ℕ × J)` with the
block operator given by its matrix in the Hermite basis of the fiber; the
differential realization on `L²(du)` is not built here.  Nothing here claims
global regularity for the classical Navier–Stokes equation, which remains the
recorded scope cut.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace AffineBlock

open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber BilinearEsa

variable {J : Type*}

/-! ## The generator -/

/-- The coordinates of the Navier–Stokes generator with affine fiber fields: in
the block `j` it is the sum of the `±2`-hopping of `κ_j` and the `±1`-hopping of
`c_j`. -/
noncomputable def affFun (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j)
    (X : ℕ × J → ℂ) : ℕ × J → ℂ :=
  fun p => (affData (hκ p.2) (hc p.2)).fst.hFun (fun n => X (n, p.2)) p.1
    + (affData (hκ p.2) (hc p.2)).snd.hFun (fun n => X (n, p.2)) p.1

theorem shiftProd_injective (k : ℕ) :
    Function.Injective (fun p : ℕ × J => (p.1 + k, p.2)) := by
  rintro ⟨a, i⟩ ⟨b, j⟩ h
  simp only [Prod.mk.injEq] at h
  obtain ⟨h1, h2⟩ := h
  simp only [Prod.mk.injEq]
  exact ⟨by omega, h2⟩

theorem support_affFun (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j)
    (X : ℕ × J → ℂ) :
    Function.support (affFun κ c hκ hc X)
      ⊆ (((fun p : ℕ × J => (p.1 + 2, p.2)) '' Function.support X)
          ∪ ((fun p : ℕ × J => (p.1 + 2, p.2)) ⁻¹' Function.support X))
        ∪ (((fun p : ℕ × J => (p.1 + 1, p.2)) '' Function.support X)
          ∪ ((fun p : ℕ × J => (p.1 + 1, p.2)) ⁻¹' Function.support X)) := by
  rintro ⟨m, j⟩ hp
  simp only [Function.mem_support, affFun] at hp
  by_cases h1 : (affData (hκ j) (hc j)).fst.hFun (fun n => X (n, j)) m = 0
  · have h2 : (affData (hκ j) (hc j)).snd.hFun (fun n => X (n, j)) m ≠ 0 := by
      intro h
      exact hp (by rw [h1, h]; ring)
    have hmem := support_hFun (affData (hκ j) (hc j)).snd (fun n => X (n, j)) h2
    rcases hmem with ⟨a, ha, hae⟩ | hpre
    · refine Or.inr (Or.inl ⟨(a, j), ha, ?_⟩)
      simp only [Prod.mk.injEq]
      exact ⟨hae, trivial⟩
    · exact Or.inr (Or.inr hpre)
  · have hmem := support_hFun (affData (hκ j) (hc j)).fst (fun n => X (n, j)) h1
    rcases hmem with ⟨a, ha, hae⟩ | hpre
    · refine Or.inl (Or.inl ⟨(a, j), ha, ?_⟩)
      simp only [Prod.mk.injEq]
      exact ⟨hae, trivial⟩
    · exact Or.inl (Or.inr hpre)

theorem affFun_finite_support (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j)
    (x : lpFiniteModes (ℕ × J)) :
    (Function.support (affFun κ c hκ hc (((x : L2I (ℕ × J))) : ℕ × J → ℂ))).Finite := by
  have hx := mem_lpFiniteModes.mp x.2
  refine Set.Finite.subset
    (((hx.image _).union (Set.Finite.preimage (shiftProd_injective 2).injOn hx)).union
      ((hx.image _).union (Set.Finite.preimage (shiftProd_injective 1).injOn hx)))
    (support_affFun κ c hκ hc _)

/-- **The Navier–Stokes generator with affine fiber fields** on the finite-mode
core of `ℓ²(ℕ × J)`: block `j` carries the field `V(u) = κ_j u + c_j`, the
constant `c_j` being the contribution of the viscous term and of the cross
terms. -/
noncomputable def affBlockH (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j) :
    lpFiniteModes (ℕ × J) →ₗ[ℂ] L2I (ℕ × J) where
  toFun x := ⟨affFun κ c hκ hc (((x : L2I (ℕ × J))) : ℕ × J → ℂ),
    memLpTwo_of_finite_support (affFun_finite_support κ c hκ hc x)⟩
  map_add' x y := by
    refine lp.ext (funext fun p => ?_)
    simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply, affFun]
    rw [hFun_add, hFun_add]
    ring
  map_smul' a x := by
    refine lp.ext (funext fun p => ?_)
    simp only [Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply,
      affFun]
    rw [hFun_smul, hFun_smul]
    ring

@[simp] theorem affBlockH_coe (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j)
    (x : lpFiniteModes (ℕ × J)) (p : ℕ × J) :
    ((affBlockH κ c hκ hc x : L2I (ℕ × J)) : ℕ × J → ℂ) p
      = affFun κ c hκ hc (((x : L2I (ℕ × J))) : ℕ × J → ℂ) p := rfl

/-! ## The block identification -/

/-- The generator preserves the blocks: it maps the `j`-th block onto itself,
acting there by the affine fiber Hamiltonian. -/
theorem affFun_embFun (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j)
    (j : J) (a : ℕ → ℂ) :
    affFun κ c hκ hc (embFun j a)
      = embFun j (fun n => (affData (hκ j) (hc j)).fst.hFun a n
          + (affData (hκ j) (hc j)).snd.hFun a n) := by
  funext p
  obtain ⟨m, j'⟩ := p
  by_cases hj : j' = j
  · subst hj
    simp only [affFun, embFun_self]
  · simp only [affFun, hFun_zero, add_zero, embFun_of_ne _ _ hj]

/-- Each block of a finite-mode state lies in the maximal domain of any fiber
comparison operator. -/
theorem blockVec_mem_maxDom' (s : ℕ → ℝ) (v : lpFiniteModes (ℕ × J)) (j : J) :
    (blockVec ((v : L2I (ℕ × J))) j) ∈ maxDom s := by
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

/-- The block of the image is the affine fiber Hamiltonian applied to the
block. -/
theorem blockVec_affBlockH (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j)
    (v : lpFiniteModes (ℕ × J)) (j : J) :
    blockVec ((affBlockH κ c hκ hc v : L2I (ℕ × J))) j
      = affH (hκ j) (hc j)
          ⟨blockVec ((v : L2I (ℕ × J))) j, blockVec_mem_maxDom' _ v j⟩ := by
  refine lp.ext (funext fun n => ?_)
  rw [show ((affH (hκ j) (hc j)
      ⟨blockVec ((v : L2I (ℕ × J))) j, blockVec_mem_maxDom' _ v j⟩ : L2I ℕ) : ℕ → ℂ) n
    = _ from PairShift.pairH_coe (affData (hκ j) (hc j)) _ n]
  rfl

/-! ## Symmetry -/

/-- **The generator is symmetric** on the finite-mode core. -/
theorem affBlockH_symmetricOn (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j) :
    SymmetricOn (lpFiniteModes (ℕ × J)) (affBlockH κ c hκ hc) := by
  intro x y
  have h1 := hasSum_inner_blocks ((affBlockH κ c hκ hc x : L2I (ℕ × J))) ((y : L2I (ℕ × J)))
  have h2 := hasSum_inner_blocks ((x : L2I (ℕ × J))) ((affBlockH κ c hκ hc y : L2I (ℕ × J)))
  have heq : ∀ j : J,
      (inner ℂ (blockVec ((affBlockH κ c hκ hc x : L2I (ℕ × J))) j)
          (blockVec ((y : L2I (ℕ × J))) j) : ℂ)
        = inner ℂ (blockVec ((x : L2I (ℕ × J))) j)
            (blockVec ((affBlockH κ c hκ hc y : L2I (ℕ × J))) j) := by
    intro j
    rw [blockVec_affBlockH κ c hκ hc x j, blockVec_affBlockH κ c hκ hc y j]
    exact affH_symmetricOn (hκ j) (hc j) ⟨_, blockVec_mem_maxDom' _ x j⟩
      ⟨_, blockVec_mem_maxDom' _ y j⟩
  simp only [heq] at h1
  exact h1.unique h2

/-! ## Essential self-adjointness -/

/-- **Block reduction of the deficiency problem.**  A deficiency vector of the
generator restricts, on each block, to a deficiency vector of the affine fiber
Hamiltonian. -/
theorem deficiencyTrivialAt_affBlockH (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j)
    (z : ℂ)
    (hblk : ∀ j, DeficiencyTrivialAt (lpFiniteModes ℕ)
      ((affH (hκ j) (hc j)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (affMu (κ j) (c j)))))) z) :
    DeficiencyTrivialAt (lpFiniteModes (ℕ × J)) (affBlockH κ c hκ hc) z := by
  intro w hw
  have hb : ∀ j, blockVec w j = 0 := by
    intro j
    refine hblk j (blockVec w j) ?_
    intro u
    have hv := hw (blockEmb j u)
    have hHcoe : ∀ p : ℕ × J,
        ((affBlockH κ c hκ hc (blockEmb j u) : L2I (ℕ × J)) : ℕ × J → ℂ) p
          = embFun j (((((affH (hκ j) (hc j))
              (Submodule.inclusion
                (finiteModes_le_maxDom (oscSymbol (affMu (κ j) (c j)))) u) :
                L2I ℕ)) : ℕ → ℂ)) p := by
      intro p
      have hb0 : ((affBlockH κ c hκ hc (blockEmb j u) : L2I (ℕ × J)) : ℕ × J → ℂ)
          = affFun κ c hκ hc (embFun j (((u : L2I ℕ)) : ℕ → ℂ)) := rfl
      rw [hb0, affFun_embFun]
      congr 1
    have h1 := inner_of_block_supported j
      ((affBlockH κ c hκ hc (blockEmb j u) : L2I (ℕ × J)))
      (((affH (hκ j) (hc j))
        (Submodule.inclusion
          (finiteModes_le_maxDom (oscSymbol (affMu (κ j) (c j)))) u) : L2I ℕ)) hHcoe w
    have h2 := inner_of_block_supported j
      (((blockEmb j u : lpFiniteModes (ℕ × J)) : L2I (ℕ × J))) ((u : L2I ℕ))
      (fun _ => rfl) w
    rw [h1, h2] at hv
    exact hv
  refine lp.ext (funext fun p => ?_)
  obtain ⟨n, j⟩ := p
  have hz := congrArg (fun v : L2I ℕ => ((v : ℕ → ℂ)) n) (hb j)
  simpa using hz

/-- **The headline.**  The Navier–Stokes generator whose fiber fields are the
affine `V(u) = κ_j u + c_j` — the bilinear advection term *together with* the
viscous term and the cross terms — is essentially self-adjoint on the
finite-mode core of `ℓ²(ℕ × J)`, for arbitrary, in particular unbounded,
families `κ, c ≥ 0`. -/
theorem affBlockH_essentiallySelfAdjointOn_core (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j)
    (hc : ∀ j, 0 ≤ c j) :
    EssentiallySelfAdjointOn (lpFiniteModes (ℕ × J)) (affBlockH κ c hκ hc) :=
  ⟨deficiencyTrivialAt_affBlockH κ c hκ hc Complex.I
      fun j => (affH_essentiallySelfAdjointOn_core (hκ j) (hc j)).1,
   deficiencyTrivialAt_affBlockH κ c hκ hc (-Complex.I)
      fun j => (affH_essentiallySelfAdjointOn_core (hκ j) (hc j)).2⟩

/-! ## Non-vacuity -/

/-- The finite-mode core is dense, so the generator is densely defined and its
essential self-adjointness is the statement it should be. -/
theorem affBlockH_domain_dense :
    Dense ((lpFiniteModes (ℕ × J) : Submodule ℂ (L2I (ℕ × J))) : Set (L2I (ℕ × J))) :=
  lpFiniteModes_dense

/-- If the strain rates are unbounded, so is the generator: essential
self-adjointness above is not a boundedness phenomenon. -/
theorem affBlockH_not_bounded (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j)
    (hunb : ∀ C : ℝ, ∃ j, C < κ j) (C : ℝ) :
    ∃ x : lpFiniteModes (ℕ × J),
      ‖((x : lpFiniteModes (ℕ × J)) : L2I (ℕ × J))‖ = 1
        ∧ C < ‖affBlockH κ c hκ hc x‖ := by
  classical
  obtain ⟨j, hj⟩ := hunb (2 * |C| + 2)
  refine ⟨⟨lp.single 2 ((0 : ℕ), j) (1 : ℂ), lpSingle_mem_lpFiniteModes _ _⟩, by simp, ?_⟩
  set x : lpFiniteModes (ℕ × J) :=
    ⟨lp.single 2 ((0 : ℕ), j) (1 : ℂ), lpSingle_mem_lpFiniteModes _ _⟩ with hxdef
  have hX : ∀ m : ℕ, ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j) = if m = 0 then 1 else 0 := by
    intro m
    simp [hxdef, lp.single_apply, Pi.single_apply, Prod.ext_iff]
  have hsnd : (affData (hκ j) (hc j)).snd.hFun
      (fun m => ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j)) 2 = 0 := by
    refine hFun_eq_zero _ (fun α hα => ?_) ?_
    · simp only [affData_shift₂] at hα
      rw [hX]
      have hne : α ≠ 0 := by omega
      simp [hne]
    · simp only [PairShift.snd_shift, affData_shift₂, hX]
      norm_num
  have hfst : (affData (hκ j) (hc j)).fst.hFun
      (fun m => ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j)) 2
        = Complex.I * ((amp (κ j) 0 : ℝ) : ℂ) := by
    have h := hFun_shift_of_single (affData (hκ j) (hc j)).fst
      (X := fun m => ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j)) (o := 0)
      (by simp [hX]) (by simp [hX])
    simpa using h
  have hcoord : ((affBlockH κ c hκ hc x : L2I (ℕ × J)) : ℕ × J → ℂ) (2, j)
      = Complex.I * ((amp (κ j) 0 : ℝ) : ℂ) := by
    change affFun κ c hκ hc _ (2, j) = _
    simp only [affFun]
    rw [hfst, hsnd, add_zero]
  have hb : ‖((affBlockH κ c hκ hc x : L2I (ℕ × J)) : ℕ × J → ℂ) (2, j)‖
      ≤ ‖(affBlockH κ c hκ hc x : L2I (ℕ × J))‖ :=
    lp.norm_apply_le_norm (by norm_num) _ _
  rw [hcoord] at hb
  have hnv : ‖Complex.I * ((amp (κ j) 0 : ℝ) : ℂ)‖ = amp (κ j) 0 := by
    rw [norm_mul, Complex.norm_I, one_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (amp_nonneg (hκ j) 0)]
  rw [hnv] at hb
  have hlow := le_amp (hκ j) 0
  have hC : C ≤ |C| := le_abs_self C
  norm_num at hlow
  linarith

end AffineBlock

end BookProof.NavierStokesFlow
