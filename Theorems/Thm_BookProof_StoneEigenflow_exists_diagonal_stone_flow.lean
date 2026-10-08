-- Generated from ChapterStoneEigenflow.lean — theorem BookProof.StoneEigenflow.exists_diagonal_stone_flow
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterStoneEigenflow
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.StoneBridge
open BookProof.StoneEigenflow


open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.EsaClosure BookProof.FarisLavine
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


theorem BookProof.StoneEigenflow.exists_diagonal_stone_flow [CompleteSpace F] {D : Submodule ℂ F} (Hc : D →ₗ[ℂ] F)
    (hdense : Dense ((D : Submodule ℂ F) : Set F)) (hsym : SymmetricOn D Hc)
    (hesa : EssentiallySelfAdjointOn D Hc) {ι : Type*} (psi : ι → D) (lam : ι → ℝ)
    (hev : ∀ α, Hc (psi α) = ((lam α : ℝ) : ℂ) • ((psi α : F))) :
    ∃ (T : UnboundedSelfAdjoint F) (U : ℝ → (F →L[ℂ] F)),
      IsSelfAdjointExtension Hc T.op ∧ IsStoneFlow T U ∧
        ∀ (α : ι) (t : ℝ),
          U t ((psi α : F)) = Complex.exp (-(Complex.I * lam α * t)) • ((psi α : F)) := by sorry
