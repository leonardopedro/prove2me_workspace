-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.wigner_symmetry_hilbert
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_key_global
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_of_key
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_imgBasis_apply
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}
variable (κ : ℂ →+* ℂ)

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ι ℂ E) (o : ι) (hT : IsWignerSymmetry T)
    (hsurj : Function.Surjective T) :
    (∃ U : E ≃ₗᵢ[ℂ] E, ∀ x, ∃ lam : ℂ, ‖lam‖ = 1 ∧ T x = lam • U x) ∨
    (∃ U : E → E, IsAntiunitary U ∧ ∀ x, ∃ lam : ℂ, ‖lam‖ = 1 ∧ T x = lam • U x) := by

  set G := imgBasis b o hT hsurj with hGdef
  have hG : ⇑G = img b T o := imgBasis_apply hT hsurj
  have hcoordG : ∀ (k : ι) (x : E), G.repr (T x) k = coord b T o k x := by
    intro k x
    rw [HilbertBasis.repr_apply_apply, hG]
    rfl
  have hbcoord : ∀ (k : ι) (x : E), b.repr x k = ⟪b k, x⟫_ℂ := fun k x =>
    b.repr_apply_apply x k
  rcases key_global (b := b) (o := o) hT with hkey | hkey
  · -- the unitary alternative
    left
    refine ⟨b.repr.trans G.repr.symm, fun x => ?_⟩
    obtain ⟨lam, hlam, hk⟩ :=
      coord_of_key (b := b) (o := o) (RingHom.id ℂ) hT (by simp) (by simp) (by simpa using hkey) x
    refine ⟨lam, hlam, ?_⟩
    have hU : HasSum (fun k => ⟪b k, x⟫_ℂ • G k) ((b.repr.trans G.repr.symm) x) := by
      have h := G.hasSum_repr_symm (b.repr x)
      simpa only [hbcoord, LinearIsometryEquiv.trans_apply] using h
    have hTx : HasSum (fun k => lam • (⟪b k, x⟫_ℂ • G k)) (T x) := by
      have h := hasSum_img_expansion (b := b) (o := o) hT x
      have hterm : ∀ k : ι, ⟪img b T o k, T x⟫_ℂ • img b T o k
          = lam • (⟪b k, x⟫_ℂ • G k) := by
        intro k
        have := hk k
        simp only [RingHom.id_apply] at this
        rw [hG, smul_smul, ← this]
        rfl
      simpa only [hterm] using h
    exact hTx.unique (hU.const_smul lam)
  · -- the antiunitary alternative
    right
    refine ⟨fun x => G.repr.symm (star (b.repr x)), ⟨?_, ?_, ?_, ?_⟩, fun x => ?_⟩
    · intro x y
      rw [map_add, star_add, map_add]
    · intro a x
      rw [map_smul, star_smul, map_smul]
      rfl
    · intro x y
      have hxy : ⟪(b.repr x : lp (fun _ : ι => ℂ) 2), b.repr y⟫_ℂ = ⟪x, y⟫_ℂ :=
        b.repr.inner_map_map x y
      have hstar : ⟪star (b.repr x), star (b.repr y)⟫_ℂ = conj ⟪b.repr x, b.repr y⟫_ℂ := by
        have h1 := lp.hasSum_inner (𝕜 := ℂ) (star (b.repr x)) (star (b.repr y))
        have h2 := (lp.hasSum_inner (𝕜 := ℂ) (b.repr x) (b.repr y)).star
        refine h1.unique ?_
        have hterm : ∀ i : ι, star ⟪(b.repr x : lp (fun _ : ι => ℂ) 2) i, (b.repr y) i⟫_ℂ
            = ⟪(star (b.repr x) : lp (fun _ : ι => ℂ) 2) i,
               (star (b.repr y) : lp (fun _ : ι => ℂ) 2) i⟫_ℂ := by
          intro i
          rw [lp.star_apply, lp.star_apply]
          simp [RCLike.inner_apply, mul_comm]
        simpa only [hterm, RCLike.star_def] using h2
      calc ⟪G.repr.symm (star (b.repr x)), G.repr.symm (star (b.repr y))⟫_ℂ
          = ⟪star (b.repr x), star (b.repr y)⟫_ℂ := G.repr.symm.inner_map_map _ _
        _ = conj ⟪(b.repr x : lp (fun _ : ι => ℂ) 2), b.repr y⟫_ℂ := hstar
        _ = conj ⟪x, y⟫_ℂ := by rw [hxy]
    · intro y
      refine ⟨b.repr.symm (star (G.repr y)), ?_⟩
      simp only [LinearIsometryEquiv.apply_symm_apply, star_star,
        LinearIsometryEquiv.symm_apply_apply]
    · obtain ⟨lam, hlam, hk⟩ :=
        coord_of_key (b := b) (o := o) (starRingEnd ℂ) hT (fun z => Complex.norm_conj z)
          (fun z => by simp) hkey x
      refine ⟨lam, hlam, ?_⟩
      have hU : HasSum (fun k => conj ⟪b k, x⟫_ℂ • G k) (G.repr.symm (star (b.repr x))) := by
        have h := G.hasSum_repr_symm (star (b.repr x))
        have hterm : ∀ k : ι, (star (b.repr x) : lp (fun _ : ι => ℂ) 2) k • G k
            = conj ⟪b k, x⟫_ℂ • G k := by
          intro k
          rw [lp.star_apply, hbcoord]
          rfl
        simpa only [hterm] using h
      have hTx : HasSum (fun k => lam • (conj ⟪b k, x⟫_ℂ • G k)) (T x) := by
        have h := hasSum_img_expansion (b := b) (o := o) hT x
        have hterm : ∀ k : ι, ⟪img b T o k, T x⟫_ℂ • img b T o k
            = lam • (conj ⟪b k, x⟫_ℂ • G k) := by
          intro k
          have := hk k
          rw [hG, smul_smul, ← this]
          rfl
        simpa only [hterm] using h
      exact hTx.unique (hU.const_smul lam)
