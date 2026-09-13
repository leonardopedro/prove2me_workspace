-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — theorem BookProof.NavierStokesFlow.LagrangianKatoRellich.hasZeroDeficiencyOn_of_lagrangian_katoRellich
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Definitions.Def_ChapterSirkBandLedger
import Definitions.Def_ChapterRitzCertificate
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich
open Filter Topology
open BookProof.NavierStokesFlow.FullEsa BookProof.NavierStokesFlow.LagrangianEsa BookProof.FarisLavine
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

theorem BookProof.NavierStokesFlow.LagrangianKatoRellich.hasZeroDeficiencyOn_of_lagrangian_katoRellich
    {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
    (d : FullEsa.NSFullData F) (L' : LagrangianFullData G) (W : F ≃ₗᵢ[ℂ] G)
    (hmap : ∀ x : d.D, W (x : F) ∈ L'.D) (hsurj : ∀ y : L'.D, ∃ x : d.D, W (x : F) = (y : G))
    (hint : ∀ x : d.D, (L'.hFull ⟨W (x : F), hmap x⟩ : G) = W ((d.hamiltonian x : F)))
    (hdrive : L'.drive = L'.P) {cc : ℝ} (hcc : 0 ≤ cc)
    (hC : ∀ v : L'.D, ‖(L'.constraintOp v : G)‖ ≤ cc * ‖(v : G)‖)
    (hT : HasZeroDeficiencyOn L'.D (secondOrder L')) :
    HasZeroDeficiencyOn d.D d.hamiltonian := by sorry
