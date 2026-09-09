import Mathlib
import BookProof.PhysHSGaussian

/-!
# Coordinate Gaussian extension of the Solovay tail

This module supplies the coordinate realization that the earlier abstract
`L²[0,1]` substrate did not expose.  The tail is an infinite sequence of real
Gaussian coordinates.  Splitting off finitely many coordinates is a measurable,
measure-preserving equivalence, and two tails can be interleaved into one.

The logical language remains deliberately small: a language is represented by a
Boolean decision procedure.  Its tensor product is conjunction on pairs, so the
combined language is decidable by construction.
-/

open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

namespace BookProof.ChapterSolovayCoordinates

/-- Standard one-dimensional Gaussian law. -/
abbrev standardGaussian : Measure ℝ := gaussianReal 0 1

/-- A finite product of standard Gaussian coordinates. -/
def gaussianHead (k : ℕ) : Measure (Fin k → ℝ) :=
  Measure.pi (fun _ : Fin k => standardGaussian)

instance gaussianHead_isProbability (k : ℕ) :
    IsProbabilityMeasure (gaussianHead k) := by
  unfold gaussianHead
  infer_instance

/-- The concrete coordinate tail. -/
abbrev CoordinateTail := ℕ → ℝ

/-- Its Mehler law: the countable product of standard Gaussians. -/
abbrev coordinateTailMeasure : Measure CoordinateTail := PhysHSGaussian.gammaMeasure

instance coordinateTailMeasure_isProbability :
    IsProbabilityMeasure coordinateTailMeasure := by
  exact PhysHSGaussian.gammaMeasure_isProbability

/-- Restriction to any finite coordinate set has the corresponding finite
product Gaussian law.  This gives the model its explicit coordinate
infrastructure without identifying the tail with the earlier abstract substrate. -/
theorem finiteCoordinateMarginal (I : Finset ℕ) :
    Measure.map I.restrict coordinateTailMeasure =
      Measure.pi (fun _ : I => standardGaussian) := by
  exact Measure.infinitePi_map_restrict (fun _ : ℕ => standardGaussian)

/-- Pushing an infinite product measure indexed by a sum type forward along the
canonical `(Π i : ι ⊕ ι', X i) ≃ (Π i : ι, X (.inl i)) × (Π j : ι', X (.inr j))`
splitting: the image is the product of the two factor product measures.  Stated
here in the direction of the inverse equivalence, where the characterization of
`Measure.infinitePi` by its values on measurable boxes applies directly. -/
theorem infinitePi_map_sumPiEquivProdPi_symm {ι ι' : Type*} {X : ι ⊕ ι' → Type*}
    [∀ i, MeasurableSpace (X i)] (mu : ∀ i, Measure (X i))
    [∀ i, IsProbabilityMeasure (mu i)] :
    Measure.map (MeasurableEquiv.sumPiEquivProdPi X).symm
      ((Measure.infinitePi fun i : ι => mu (Sum.inl i)).prod
        (Measure.infinitePi fun j : ι' => mu (Sum.inr j))) = Measure.infinitePi mu := by
  refine Measure.eq_infinitePi _ fun s t ht => ?_
  rw [Measure.map_apply (MeasurableEquiv.measurable _)
    (MeasurableSet.pi s.countable_toSet fun _ _ => ht _)]
  have hpre : ⇑(MeasurableEquiv.sumPiEquivProdPi X).symm ⁻¹' ((s : Set (ι ⊕ ι')).pi t)
      = ((s.toLeft : Set ι).pi fun i => t (Sum.inl i)) ×ˢ
        ((s.toRight : Set ι').pi fun j => t (Sum.inr j)) := by
    ext ⟨a, b⟩
    constructor
    · intro h
      refine ⟨fun i hi => ?_, fun j hj => ?_⟩
      · simpa using h (Sum.inl i) (by simpa using hi)
      · simpa using h (Sum.inr j) (by simpa using hj)
    · rintro ⟨h1, h2⟩ i hi
      cases i with
      | inl i => simpa using h1 i (by simpa using hi)
      | inr j => simpa using h2 j (by simpa using hi)
  rw [hpre, Measure.prod_prod,
    Measure.infinitePi_pi (μ := fun i : ι => mu (Sum.inl i)) (s := s.toLeft)
      (t := fun i => t (Sum.inl i)) (fun i _ => ht _),
    Measure.infinitePi_pi (μ := fun j : ι' => mu (Sum.inr j)) (s := s.toRight)
      (t := fun j => t (Sum.inr j)) (fun j _ => ht _),
    Finset.prod_sum_eq_prod_toLeft_mul_prod_toRight s (fun i => mu i (t i))]

/-- Forward form of `infinitePi_map_sumPiEquivProdPi_symm` when the left index
type is finite: the infinite product over `ι ⊕ ι'` splits as the finite product
measure on the `ι`-block times the infinite product measure on the `ι'`-block. -/
theorem infinitePi_map_sumPiEquivProdPi {ι ι' : Type*} [Fintype ι] {X : ι ⊕ ι' → Type*}
    [∀ i, MeasurableSpace (X i)] (mu : ∀ i, Measure (X i))
    [∀ i, IsProbabilityMeasure (mu i)] :
    Measure.map (MeasurableEquiv.sumPiEquivProdPi X) (Measure.infinitePi mu)
      = (Measure.pi fun i : ι => mu (Sum.inl i)).prod
        (Measure.infinitePi fun j : ι' => mu (Sum.inr j)) := by
  rw [← Measure.infinitePi_eq_pi]
  exact (MeasurableEquiv.map_apply_eq_iff_map_symm_apply_eq _).2
    (infinitePi_map_sumPiEquivProdPi_symm mu).symm

/-- Split the first `k` coordinates from an infinite sequence. -/
def tailSplitEquiv (k : ℕ) : CoordinateTail ≃ᵐ (Fin k → ℝ) × CoordinateTail :=
  (MeasurableEquiv.piCongrLeft (fun _ : ℕ => ℝ) (finSumNatEquiv k)).symm.trans
    (MeasurableEquiv.sumPiEquivProdPi (fun _ : Fin k ⊕ ℕ => ℝ))

/-- The coordinate splitting is exactly Gaussian-product preserving. -/
theorem tailSplitEquiv_map (k : ℕ) :
    Measure.map (tailSplitEquiv k) coordinateTailMeasure =
      (gaussianHead k).prod coordinateTailMeasure :=
  by
  dsimp [coordinateTailMeasure, gaussianHead, standardGaussian, tailSplitEquiv,
      PhysHSGaussian.gammaMeasure]
  have h_reindex : Measure.map
      ((MeasurableEquiv.piCongrLeft (fun _ : ℕ => ℝ) (finSumNatEquiv k)).symm)
      (Measure.infinitePi (fun _ : ℕ => gaussianReal 0 1)) =
      Measure.infinitePi (fun _ : Fin k ⊕ ℕ => gaussianReal 0 1) := by
    have h := Measure.infinitePi_map_piCongrLeft
      (fun _ : Fin k ⊕ ℕ => gaussianReal 0 1) (finSumNatEquiv k).symm
    have h_eq : ((MeasurableEquiv.piCongrLeft (fun _ : ℕ => ℝ)
      (finSumNatEquiv k)).symm : (ℕ → ℝ) → (Fin k ⊕ ℕ → ℝ)) =
      (MeasurableEquiv.piCongrLeft (fun _ : Fin k ⊕ ℕ => ℝ)
      (finSumNatEquiv k).symm : (ℕ → ℝ) → (Fin k ⊕ ℕ → ℝ)) := by
      ext f x
      simp [MeasurableEquiv.piCongrLeft, MeasurableEquiv.coe_mk,
        Equiv.piCongrLeft_apply]
    simpa [h_eq] using h
  have h_split : Measure.map
      (MeasurableEquiv.sumPiEquivProdPi (fun _ : Fin k ⊕ ℕ => ℝ))
      (Measure.infinitePi (fun _ : Fin k ⊕ ℕ => gaussianReal 0 1)) =
      (Measure.pi (fun _ : Fin k => gaussianReal 0 1)).prod
      (Measure.infinitePi (fun _ : ℕ => gaussianReal 0 1)) := by
    exact infinitePi_map_sumPiEquivProdPi (fun _ : Fin k ⊕ ℕ => gaussianReal 0 1)
  calc
    Measure.map
      ((MeasurableEquiv.piCongrLeft (fun _ : ℕ => ℝ) (finSumNatEquiv k)).symm.trans
        (MeasurableEquiv.sumPiEquivProdPi fun _ : Fin k ⊕ ℕ => ℝ))
      (Measure.infinitePi (fun _ : ℕ => gaussianReal 0 1))
        = Measure.map
          (MeasurableEquiv.sumPiEquivProdPi fun _ : Fin k ⊕ ℕ => ℝ)
          (Measure.map
            ((MeasurableEquiv.piCongrLeft (fun _ : ℕ => ℝ) (finSumNatEquiv k)).symm)
            (Measure.infinitePi (fun _ : ℕ => gaussianReal 0 1))) := by
      simpa [MeasurableEquiv.coe_trans] using
        (Measure.map_map
          (MeasurableEquiv.sumPiEquivProdPi (fun _ : Fin k ⊕ ℕ => ℝ)).measurable
          ((MeasurableEquiv.piCongrLeft (fun _ : ℕ => ℝ) (finSumNatEquiv k)).symm.measurable)).symm
    _ = Measure.map
          (MeasurableEquiv.sumPiEquivProdPi fun _ : Fin k ⊕ ℕ => ℝ)
          (Measure.infinitePi (fun _ : Fin k ⊕ ℕ => gaussianReal 0 1)) := by rw [h_reindex]
    _ = (Measure.pi fun _ : Fin k => gaussianReal 0 1).prod
          (Measure.infinitePi (fun _ : ℕ => gaussianReal 0 1)) := by rw [h_split]
    _ = (gaussianHead k).prod coordinateTailMeasure := rfl

/-- Bijection used to interleave two sequences into one. -/
def pairIndexEquiv : Fin 2 × ℕ ≃ ℕ :=
  (Equiv.prodCongr finTwoEquiv (Equiv.refl ℕ)).trans
    Equiv.boolProdNatEquivNat

/-- Pack a pair of tails into one by interleaving coordinates.  The intermediate
`Fin 2 → ℕ → ℝ` presentation makes the product-measure argument explicit. -/
def tailTensorEquiv : CoordinateTail × CoordinateTail ≃ᵐ CoordinateTail :=
  MeasurableEquiv.finTwoArrow.symm |>.trans
    ((MeasurableEquiv.curry (Fin 2) ℕ ℝ).symm.trans
      (MeasurableEquiv.piCongrLeft (fun _ : ℕ => ℝ) pairIndexEquiv))

/-- Interleaving realizes the tensor/product law of two coordinate tails as one
copy of the same tail law. -/
theorem tailTensorEquiv_map :
    Measure.map tailTensorEquiv
      (coordinateTailMeasure.prod coordinateTailMeasure) = coordinateTailMeasure := by
  let e1 : CoordinateTail × CoordinateTail ≃ᵐ (Fin 2 → CoordinateTail) :=
    MeasurableEquiv.finTwoArrow.symm
  let e2 : (Fin 2 → CoordinateTail) ≃ᵐ (Fin 2 × ℕ → ℝ) :=
    (MeasurableEquiv.curry (Fin 2) ℕ ℝ).symm
  let e3 : (Fin 2 × ℕ → ℝ) ≃ᵐ CoordinateTail :=
    MeasurableEquiv.piCongrLeft (fun _ : ℕ => ℝ) pairIndexEquiv
  change Measure.map (e3 ∘ (e2 ∘ e1))
    (coordinateTailMeasure.prod coordinateTailMeasure) = coordinateTailMeasure
  rw [← Measure.map_map e3.measurable (e2.measurable.comp e1.measurable)]
  rw [← Measure.map_map e2.measurable e1.measurable]
  have h1 : Measure.map e1
      (coordinateTailMeasure.prod coordinateTailMeasure) =
      Measure.pi (fun _ : Fin 2 => coordinateTailMeasure) := by
    exact (MeasurableEquiv.map_apply_eq_iff_map_symm_apply_eq e1).2
      (measurePreserving_finTwoArrow coordinateTailMeasure).map_eq.symm
  rw [h1, ← Measure.infinitePi_eq_pi]
  change Measure.map e3
    (Measure.map (MeasurableEquiv.curry (Fin 2) ℕ ℝ).symm
      (Measure.infinitePi fun _ : Fin 2 => coordinateTailMeasure)) =
    coordinateTailMeasure
  change Measure.map e3
    (Measure.map (MeasurableEquiv.curry (Fin 2) ℕ ℝ).symm
      (Measure.infinitePi fun _ : Fin 2 =>
        Measure.infinitePi fun _ : ℕ => standardGaussian)) =
    Measure.infinitePi fun _ : ℕ => standardGaussian
  rw [Measure.infinitePi_map_curry_symm]
  exact Measure.infinitePi_map_piCongrLeft
    (fun _ : ℕ => standardGaussian) pairIndexEquiv

/-- A finite head coupled to the coordinate Gaussian tail. -/
abbrev CoordinateSpace (N : ℕ) := (Fin N → ℝ) × CoordinateTail

/-- Product state law for an arbitrary probability distribution on the head. -/
def coordinateStateMeasure (N : ℕ) (headDist : Measure (Fin N → ℝ))
    [IsProbabilityMeasure headDist] : Measure (CoordinateSpace N) :=
  headDist.prod coordinateTailMeasure

instance coordinateStateMeasure_isProbability (N : ℕ)
    (headDist : Measure (Fin N → ℝ)) [IsProbabilityMeasure headDist] :
    IsProbabilityMeasure (coordinateStateMeasure N headDist) := by
  unfold coordinateStateMeasure
  infer_instance

/-- Split `k` Gaussian coordinates out of the tail and append them to the finite
head.  This is the coordinate-level cross-dimensional enlargement. -/
def enlargeEquiv (N k : ℕ) :
    CoordinateSpace N ≃ᵐ CoordinateSpace (N + k) :=
  (MeasurableEquiv.prodCongr (MeasurableEquiv.refl (Fin N → ℝ))
      (tailSplitEquiv k)).trans <|
    MeasurableEquiv.prodAssoc.symm.trans <|
      MeasurableEquiv.prodCongr
        ((MeasurableEquiv.piCongrLeft (fun _ : Fin (N + k) => ℝ)
          (finSumFinEquiv (m := N) (n := k))).symm.trans
          (MeasurableEquiv.sumPiEquivProdPi (fun _ : Fin N ⊕ Fin k => ℝ))).symm
        (MeasurableEquiv.refl CoordinateTail)

/-- The enlarged head law obtained by adjoining `k` independent Gaussian
coordinates and concatenating the two finite blocks. -/
def enlargedHeadMeasure (N k : ℕ) (headDist : Measure (Fin N → ℝ)) :
    Measure (Fin (N + k) → ℝ) :=
  Measure.map
    ((MeasurableEquiv.piCongrLeft (fun _ : Fin (N + k) => ℝ)
      (finSumFinEquiv (m := N) (n := k))).symm.trans
      (MeasurableEquiv.sumPiEquivProdPi (fun _ : Fin N ⊕ Fin k => ℝ))).symm
    (headDist.prod (gaussianHead k))

instance enlargedHeadMeasure_isProbability (N k : ℕ)
    (headDist : Measure (Fin N → ℝ)) [IsProbabilityMeasure headDist] :
    IsProbabilityMeasure (enlargedHeadMeasure N k headDist) := by
  unfold enlargedHeadMeasure
  exact Measure.isProbabilityMeasure_map
    (MeasurableEquiv.measurable _).aemeasurable

/-- Enlarging a state transports `headDist × Gaussian(k) × tail` to the
corresponding `(N+k)`-head state law. -/
theorem enlargeEquiv_map (N k : ℕ) (headDist : Measure (Fin N → ℝ))
    [IsProbabilityMeasure headDist] :
    Measure.map (enlargeEquiv N k) (coordinateStateMeasure N headDist) =
      coordinateStateMeasure (N + k) (enlargedHeadMeasure N k headDist) := by
  simp only [coordinateStateMeasure]
  have h_tailSplit : Measure.map (↑(tailSplitEquiv k)) coordinateTailMeasure =
      (gaussianHead k).prod coordinateTailMeasure := tailSplitEquiv_map k
  rw [enlargeEquiv]
  -- Define the intermediate equivalences
  let e1 : (Fin N → ℝ) × CoordinateTail ≃ᵐ (Fin N → ℝ) × ((Fin k → ℝ) × CoordinateTail) :=
    (MeasurableEquiv.refl (Fin N → ℝ)).prodCongr (tailSplitEquiv k)
  let e2 : (Fin N → ℝ) × ((Fin k → ℝ) × CoordinateTail) ≃ᵐ ((Fin N → ℝ) × (Fin k → ℝ)) ×
      CoordinateTail :=
    MeasurableEquiv.prodAssoc.symm
  let e3 : ((Fin N → ℝ) × (Fin k → ℝ)) × CoordinateTail ≃ᵐ (Fin (N + k) → ℝ) × CoordinateTail :=
    ((MeasurableEquiv.piCongrLeft (fun x => ℝ) finSumFinEquiv).symm.trans
      (MeasurableEquiv.sumPiEquivProdPi fun x => ℝ)).symm.prodCongr (MeasurableEquiv.refl
          CoordinateTail)
  let e23 := e2.trans e3
  let e123 := e1.trans e23
  -- The enlargeEquiv is e1.trans (e2.trans e3)
  have h_eq : ∀ x, (((MeasurableEquiv.refl (Fin N → ℝ)).prodCongr (tailSplitEquiv k)).trans
      (MeasurableEquiv.prodAssoc.symm.trans
        (((MeasurableEquiv.piCongrLeft (fun x => ℝ) finSumFinEquiv).symm.trans
                (MeasurableEquiv.sumPiEquivProdPi fun x => ℝ)).symm.prodCongr
          (MeasurableEquiv.refl CoordinateTail)))) x = e3 (e2 (e1 x)) := by
    intro x; rfl
  have hfun : (⇑(((MeasurableEquiv.refl (Fin N → ℝ)).prodCongr (tailSplitEquiv k)).trans
      ((MeasurableEquiv.prodAssoc.symm).trans
        (((MeasurableEquiv.piCongrLeft (fun x => ℝ) finSumFinEquiv).symm.trans
                (MeasurableEquiv.sumPiEquivProdPi fun x => ℝ)).symm.prodCongr
          (MeasurableEquiv.refl CoordinateTail)))) : (Fin N → ℝ) × CoordinateTail → _) =
      (fun x => e3 (e2 (e1 x))) := funext h_eq
  rw [hfun]
  have hcomp : (fun x => e3 (e2 (e1 x))) = e3 ∘ e2 ∘ e1 := rfl
  rw [hcomp]
  have h_comp : (⇑e3 ∘ ⇑e2 ∘ ⇑e1 : (Fin N → ℝ) × CoordinateTail → _) = ⇑(e1.trans e23) := rfl
  rw [h_comp]
  have h_trans : ⇑(e1.trans e23) = ⇑e23 ∘ ⇑e1 := rfl
  rw [h_trans, ← Measure.map_map (MeasurableEquiv.measurable e23) (MeasurableEquiv.measurable e1)]
  simp only [e1]
  have h_map_eq : Measure.map (⇑((MeasurableEquiv.refl (Fin N → ℝ)).prodCongr (tailSplitEquiv k)))
      (headDist.prod coordinateTailMeasure) = headDist.prod (Measure.map (tailSplitEquiv k)
          coordinateTailMeasure) := by
    simp? +unfoldPartialApp [MeasurableEquiv.prodCongr]
    rw [show Prod.map id (⇑(tailSplitEquiv k)) = (fun p : (Fin N → ℝ) × CoordinateTail => (p.1,
        tailSplitEquiv k p.2)) from rfl]
    rw [show (fun p : (Fin N → ℝ) × CoordinateTail => (p.1, tailSplitEquiv k p.2)) = Prod.map (id :
        (Fin N → ℝ) → (Fin N → ℝ)) (tailSplitEquiv k) from rfl]
    ext s hs
    rw [Measure.map_apply (by measurability : Measurable _) hs]
    rw [Measure.prod_apply (by measurability : MeasurableSet (Prod.map id (tailSplitEquiv k) ⁻¹'
                               s))]
    rw [Measure.prod_apply hs]
    apply congr_arg
    funext x
    rw [Measure.map_apply (MeasurableEquiv.measurable _) (by measurability : MeasurableSet _)]
    apply congr_arg
    funext y
    simp [Set.preimage]
  rw [h_map_eq, h_tailSplit]
  unfold enlargedHeadMeasure
  -- Goal: Measure.map e23 (headDist.prod ((gaussianHead k).prod coordinateTailMeasure)) = 
  --       (Measure.map e3' (headDist.prod (gaussianHead k))).prod coordinateTailMeasure
  -- where e3' is the concatenation equiv
  have he23 : ⇑e23 = ⇑e3 ∘ ⇑e2 := rfl
  rw [he23, ← Measure.map_map (MeasurableEquiv.measurable e3) (MeasurableEquiv.measurable e2)]
  simp only [e3]
  -- Step 1: Use Measure.map_map to combine e3.prodCongr refl and e2
  rw [Measure.map_map (MeasurableEquiv.measurable _) (MeasurableEquiv.measurable e2)]
  -- The composition (e3.prodCongr refl) ∘ e2 = ((e3'.prodCongr refl) ∘ e2)
  -- We need to simplify: (e3'.prodCongr refl) ∘ e2
  -- e2 reassociates, so (e3'.prodCongr refl) ∘ e2 = (e3' ∘ fst₂) ⊗ refl ∘ snd₂ where fst₂, snd₂ are
  -- projections through e2
  -- Actually, let's just use simp to simplify the composition
  simp only [Function.comp_def]
  -- The function is: fun (a, (b, c)) => (e3' (a, b), c)
  -- This is equivalent to Prod.map e3' id composed with e2
  have h_fun : (fun x => (((MeasurableEquiv.piCongrLeft (fun x => ℝ) finSumFinEquiv).symm.trans 
      (MeasurableEquiv.sumPiEquivProdPi fun x => ℝ)).symm.prodCongr (MeasurableEquiv.refl
          CoordinateTail)) (e2 x)) 
      = Prod.map (((MeasurableEquiv.piCongrLeft (fun x => ℝ) finSumFinEquiv).symm.trans 
      (MeasurableEquiv.sumPiEquivProdPi fun x => ℝ)).symm) id ∘ e2 := rfl
  rw [h_fun]
  -- Now use Measure.prod_map to split Prod.map e3' id
  ext s hs
  rw [Measure.prod_apply hs]
  -- LHS: Measure.map (Prod.map e3' id ∘ e2) μ
  -- Rewrite using Measure.map_map
  rw [← Measure.map_map (by measurability : Measurable _) (MeasurableEquiv.measurable e2)]
  let e3' : (Fin N → ℝ) × (Fin k → ℝ) ≃ᵐ (Fin (N + k) → ℝ) :=
    ((MeasurableEquiv.piCongrLeft (fun x => ℝ) (finSumFinEquiv (m := N) (n := k))).symm.trans
      (MeasurableEquiv.sumPiEquivProdPi fun x => ℝ)).symm
  have h1 : (Measure.map (Prod.map e3' id) (Measure.map e2 (headDist.prod ((gaussianHead k).prod
      coordinateTailMeasure)))) s =
      (Measure.map e2 (headDist.prod ((gaussianHead k).prod coordinateTailMeasure))) (Prod.map e3'
          id ⁻¹' s) := by
    apply Measure.map_apply
    · measurability
    · measurability
  rw [h1]
  -- Apply Measure.map_apply to LHS
  have h2 : (Measure.map e2 (headDist.prod ((gaussianHead k).prod coordinateTailMeasure)))
      (Prod.map e3' id ⁻¹' s) =
      (headDist.prod ((gaussianHead k).prod coordinateTailMeasure))
        (e2 ⁻¹' (Prod.map e3' id ⁻¹' s)) := by
    apply Measure.map_apply
    · exact MeasurableEquiv.measurable e2
    · measurability
  rw [h2]
  -- Simplify the preimage: e2 = prodAssoc.symm maps (a, (b, c)) ↦ ((a, b), c)
  -- So e2 ⁻¹' (Prod.map e3' id ⁻¹' s) = {(a, b, c) | (e3'(a, b), c) ∈ s}
  have h_preimage : ⇑e2 ⁻¹' (Prod.map ⇑e3' id ⁻¹' s) = 
      {p : (Fin N → ℝ) × (Fin k → ℝ) × CoordinateTail | (e3' (p.1, p.2.1), p.2.2) ∈ s} := by
    ext ⟨a, b, c⟩
    simp [Set.mem_preimage, Prod.map, e2]; rfl
  rw [h_preimage]
  -- Use Measure.prod_apply on LHS
  have h_meas : MeasurableSet {p : (Fin N → ℝ) × (Fin k → ℝ) × CoordinateTail | (e3' (p.1, p.2.1),
      p.2.2) ∈ s} := by
    have : Measurable (fun p : (Fin N → ℝ) × (Fin k → ℝ) × CoordinateTail => (e3' (p.1, p.2.1),
        p.2.2)) := by
      measurability
    exact this hs
  rw [Measure.prod_apply h_meas]
  -- Simplify the inner set: Prod.mk x ⁻¹' {p | (e3' (p.1, p.2.1), p.2.2) ∈ s}
  -- = {(b, c) | (e3' (x, b), c) ∈ s}
  have h_inner : ∀ x : Fin N → ℝ,    Prod.mk x ⁻¹' {p : (Fin N → ℝ) × (Fin k → ℝ) × CoordinateTail |
      (e3' (p.1, p.2.1), p.2.2) ∈ s} = 
      {(b, c) : (Fin k → ℝ) × CoordinateTail | (e3' (x, b), c) ∈ s} := by
    intro x
    ext ⟨b, c⟩
    simp []
  simp_rw [h_inner]
  -- Apply Measure.prod_apply to inner measure
  have h_inner_meas : ∀ x : Fin N → ℝ,    MeasurableSet {(b, c) : (Fin k → ℝ) × CoordinateTail |
      (e3' (x, b), c) ∈ s} := by
    intro x
    have : Measurable (fun p : (Fin k → ℝ) × CoordinateTail => (e3' (x, p.1), p.2)) := by
      measurability
    exact this hs
  -- Rewrite using Measure.prod_apply inside the integral
  have h_lhs_eq : ∀ x : Fin N → ℝ,    ((gaussianHead k).prod coordinateTailMeasure) {(b, c) | (e3'
      (x, b), c) ∈ s} =
      ∫⁻ (b : Fin k → ℝ), coordinateTailMeasure {c | (e3' (x, b), c) ∈ s} ∂gaussianHead k := by
    intro x
    exact Measure.prod_apply (h_inner_meas x)
  simp_rw [h_lhs_eq]
  -- The goal should now be to show LHS = RHS after the previous rewrites
  -- Define the function we're integrating
  let f : (Fin N → ℝ) → (Fin k → ℝ) → ℝ≥0∞ := fun x b => coordinateTailMeasure {c | (e3' (x, b), c)
      ∈ s}
  -- Measurability of the section measure
  have hg : Measurable (fun x => coordinateTailMeasure {x_1 | (x, x_1) ∈ s}) := 
    measurable_measure_prodMk_left hs
  -- Show measurability of f
  have h_f_meas : AEMeasurable (fun p : (Fin N → ℝ) × (Fin k → ℝ) => f p.1 p.2) (headDist.prod
      (gaussianHead k)) := by
    have heq : (fun p : (Fin N → ℝ) × (Fin k → ℝ) => f p.1 p.2) = (fun x => coordinateTailMeasure
        {x_1 | (x, x_1) ∈ s}) ∘ e3' := rfl
    rw [heq]
    exact AEMeasurable.comp_aemeasurable (Measurable.aemeasurable hg) (MeasurableEquiv.measurable
        e3').aemeasurable
  -- Apply Fubini's theorem to LHS: ∫⁻ x, ∫⁻ b, f(x,b) ∂ν ∂μ = ∫⁻ p, f(p.1, p.2) ∂(μ.prod ν)
  have h_fubini : ∫⁻ (x : Fin N → ℝ), ∫⁻ (b : Fin k → ℝ), f x b ∂(gaussianHead k) ∂headDist = 
      ∫⁻ (p : (Fin N → ℝ) × (Fin k → ℝ)), f p.1 p.2 ∂(headDist.prod (gaussianHead k)) := by
    rw [← MeasureTheory.lintegral_lintegral h_f_meas]
  rw [h_fubini]
  -- Show that Prod.mk x ⁻¹' s = {x_1 | (x, x_1) ∈ s}
  have h_set_eq : ∀ x : Fin (N + k) → ℝ, Prod.mk x ⁻¹' s = {x_1 | (x, x_1) ∈ s} := by
    intro x; ext y; simp [Set.mem_preimage]
  simp_rw [h_set_eq]
  -- Now show both integrals are equal using change of variables
  -- RHS integral equals LHS by change of variables with e3'
  have h_rhs_eq : ∫⁻ (x : Fin (N + k) → ℝ), coordinateTailMeasure {x_1 | (x, x_1) ∈ s} 
      ∂Measure.map (⇑e3') (headDist.prod (gaussianHead k)) = 
      ∫⁻ (p : (Fin N → ℝ) × (Fin k → ℝ)), coordinateTailMeasure {x_1 | (e3' p, x_1) ∈ s} 
      ∂(headDist.prod (gaussianHead k)) := by
    symm
    rw [MeasureTheory.lintegral_map hg (MeasurableEquiv.measurable e3')]
  rw [h_rhs_eq]
/-- A decidable language is an explicit Boolean classifier. -/
structure DecidableLanguage (α : Type*) where
  decide : α → Bool

/-- Tensor product of two decidable languages. -/
def DecidableLanguage.tensor {α β : Type*}
    (L₁ : DecidableLanguage α) (L₂ : DecidableLanguage β) :
    DecidableLanguage (α × β) where
  decide x := L₁.decide x.1 && L₂.decide x.2

/-- Membership in the tensor language is decidable. -/
instance tensor_language_membership_decidable {α β : Type*}
    (L₁ : DecidableLanguage α) (L₂ : DecidableLanguage β) (x : α × β) :
    Decidable ((L₁.tensor L₂).decide x = true) := by
  infer_instance

/-- The tensor decision procedure computes conjunction of the component
procedures. -/
@[simp] theorem tensor_decide_apply {α β : Type*}
    (L₁ : DecidableLanguage α) (L₂ : DecidableLanguage β) (x : α × β) :
    (L₁.tensor L₂).decide x = (L₁.decide x.1 && L₂.decide x.2) := rfl

end BookProof.ChapterSolovayCoordinates
