-- Generated from ChapterParityHiggs.lean — solution of BookProof.ChapterParityHiggs.higgsReal_mul_conj
import Mathlib
import Definitions.Def_ChapterParityHiggs
import Theorems.Thm_BookProof_ChapterParityHiggs_pauli2_pseudoreal
import Theorems.Thm_BookProof_ChapterParityHiggs_pseudoreal_kron_pseudoreal_real
open BookProof.ChapterParityHiggs



open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution : higgsReal * (higgsReal.map (starRingEnd ℂ)) = 1 := pseudoreal_kron_pseudoreal_real pauli2 pauli2 pauli2_pseudoreal pauli2_pseudoreal
